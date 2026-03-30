resource "aws_sns_topic" "alarm_topic" {
  name = "terraform-cpu-alarm-topic"

  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "sns-cpu-alarm-topic"
    }
  )
}