[no-cd]
init:
  terragrunt init -upgrade

[no-cd]
plan:
  terragrunt plan -out tfplan

[no-cd]
apply:
  terragrunt apply tfplan
