[no-cd]
init:
  terragrunt init -upgrade

[no-cd]
plan:
  terragrunt plan -out tfplan

[no-cd]
apply:
  terragrunt apply tfplan

check:
  pre-commit run -a

fmt:
  tofu fmt -recursive -write
  terragrunt run-all hclfmt --terragrunt-non-interactive
