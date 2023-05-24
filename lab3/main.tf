module "s3_frontend" {
  source = "../modules/s3-frontend"

  context = module.naming.context
  object_name = "index"
  path_to_file = ""
}