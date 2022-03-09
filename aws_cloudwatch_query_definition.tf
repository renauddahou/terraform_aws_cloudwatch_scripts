resource "aws_cloudwatch_query_definition" "demo_definition" {
  name = "demo_query"

  log_group_names = [
    "route53_logs"
  ]

  query_string = <<EOF
fields @timestamp, @message
| sort @timestamp desc
| limit 25
EOF
}