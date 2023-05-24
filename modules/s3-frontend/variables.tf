variable "context" {
  description = "Label module context"
}

variable "path_to_file" {
  description = "Path to upload"
  type        = string
}

variable "object_name" {
  description = "Name of object in S3"
  type        = string
}