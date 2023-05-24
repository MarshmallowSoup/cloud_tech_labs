output "website_endpoint" {
  description = "Website endpoint."
  value       = aws_s3_bucket_website_configuration.frontend.website_endpoint
}