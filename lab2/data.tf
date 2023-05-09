data "template_file" "crud_policy_courses" { 
  template = file("${path.module}/templates/policy.json.tpl")
  vars = {
    table_arn = module.courses_table.table_arn
  }
}

 
data "template_file" "crud_policy_authors" { 
  template = file("${path.module}/templates/policy.json.tpl")
  vars = {
    table_arn     = module.authors_table.table_arn
  }
}