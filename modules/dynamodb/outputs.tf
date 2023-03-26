output "table_name" {
  description = "Name of the table"
  value       = aws_dynamodb_table.db.id
}

output "table_arn" {
  description = "ARN of the table"
  value       = aws_dynamodb_table.db.arn
}