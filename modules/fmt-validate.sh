#!/bin/bash

# Change directory into every subdirectory of the current directory
for d in */ ; do
  echo ===============================
  echo $d
  echo ===============================
  cd "$d"
  terraform init
  terraform fmt 
  terraform fmt -check
  terraform validate
  terraform-docs markdown . --output-file README.md
  cd ..
done