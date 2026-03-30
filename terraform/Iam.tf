# IAM Roles and Policies for ECS, GitLab CI/CD, and Datadog

# 1. ECS Task Execution Role
# Allows ECS agent to pull images from ECR and write logs to CloudWatch
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "ecs-task-execution-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 2. ECS Task Role
# Permissions for the application running inside the container
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "ecs-task-role"
    }
  )
}

# Example: S3 Read Only for the task (if needed)
resource "aws_iam_role_policy_attachment" "ecs_task_s3_read" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# 3. GitLab CI/CD - OIDC Configuration
# Allows GitLab runners to assume an AWS role without access keys
resource "aws_iam_openid_connect_provider" "gitlab" {
  url             = "https://gitlab.com"
  client_id_list  = ["https://gitlab.com"]
  thumbprint_list = ["b3dd7606d2b5a8b94559b65a5bcb3d1d20e7e57f"] # Default GitLab.com thumbprint
}

resource "aws_iam_role" "gitlab_ci_role" {
  name = "gitlab-ci-ecs-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          Federated = aws_iam_openid_connect_provider.gitlab.arn
        },
        Condition = {
          StringLike = {
            "gitlab.com:sub" : "project_path:${var.gitlab_project_path}:ref_type:branch:ref:main"
          }
        }
      }
    ]
  })

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "gitlab-ci-deploy-role"
    }
  )
}

# Permissions for GitLab to deploy to ECS and Push to ECR
resource "aws_iam_role_policy" "gitlab_ci_policy" {
  name = "gitlab-ci-deploy-policy"
  role = aws_iam_role.gitlab_ci_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeTaskDefinition",
          "ecs:ListTasks",
          "ecs:DescribeTasks"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = [
          aws_iam_role.ecs_task_execution_role.arn,
          aws_iam_role.ecs_task_role.arn
        ]
      }
    ]
  })
}

# 4. Datadog Monitoring Role
# Allows Datadog to pull metrics via cross-account trust
resource "aws_iam_role" "datadog_monitoring_role" {
  name = "datadog-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          AWS = "arn:aws:iam::464622532012:root" # Datadog AWS Account ID
        },
        Condition = {
          StringEquals = {
            "sts:ExternalId" : var.datadog_external_id
          }
        }
      }
    ]
  })

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "datadog-monitoring"
    }
  )
}

resource "aws_iam_role_policy_attachment" "datadog_read_only" {
  role       = aws_iam_role.datadog_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

