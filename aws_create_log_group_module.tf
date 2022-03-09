module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 2.0"

  name              = "lambda_logGroup"
  retention_in_days = 120
}