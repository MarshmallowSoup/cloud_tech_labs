module "s3_frontend" {
  source = "../modules/s3-frontend"

  context = module.naming.context
  folder_path = "currency-converter/build"
  files =  fileset(path.module, "/currency-converter/build/**")

  depends_on = [null_resource.frontend_build]
}

resource "null_resource" "frontend_build" {
  provisioner "local-exec" {
    command = "cd currency-converter && npm i && npm run build"
  }
}