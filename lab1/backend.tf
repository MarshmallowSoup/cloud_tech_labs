terraform {
  backend "s3" {
    bucket         = "labs-back"
    key            = "lab1/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "labs-back-lab1"
  }
}