# Alarm
resource "aws_cloudwatch_metric_alarm" "account_billing_alarm" {
  alarm_name          = "account-billing-alarm-${module.labels.id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  threshold           = var.monthly_billing_threshold
  alarm_actions       = aws_sns_topic.sns_alert_topic[0].arn

  dimensions = {
    Currency      = var.currency
    LinkedAccount = var.aws_account_id
  }

  tags = module.labels.tags
}


# SNS Topic
resource "aws_sns_topic" "sns_alert_topic" {
  count = var.create_sns_topic ? 1 : 0
  name  = "billing-alarm-notification-${lower(var.currency)}-${var.aws_env}"

  tags = module.labels.tags
}