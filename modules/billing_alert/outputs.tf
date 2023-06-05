output "sns_topic_arn" {
  value = length(aws_sns_topic.sns_alert_topic) > 0 ? aws_sns_topic.sns_alert_topic[*].arn : null
}