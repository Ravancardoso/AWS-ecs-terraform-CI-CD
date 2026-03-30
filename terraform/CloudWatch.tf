resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "ecs-aws-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU/Task média do ASG acima de 60%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn
  ]

  tags = merge(local.default_tags, local.environment_tags)
}
