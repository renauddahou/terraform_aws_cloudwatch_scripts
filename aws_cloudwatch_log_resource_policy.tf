data "aws_iam_policy_document" "route53-logging-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["rn:aws:logs:us-east-2:585584209241:log-group:route53_logs:*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "route53-logging-policy" {
  policy_document = data.aws_iam_policy_document.route53-logging-policy.json
  policy_name     = "route53-logging-policy"
}
