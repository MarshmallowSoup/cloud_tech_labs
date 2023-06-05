output "sns_topic_arn" {
  value = aws_sns_topic.sns_alert_topic.arn
  count = var.create_sns_topic ? 1 : 0
}