terraform {
  backend "s3" {
    bucket         = "labs-back"
    key            = "lab2/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "labs-back-lab1"
  }
}