/*resource "aws_cloudwatch_log_subscription_filter" "route53_logfilter" {
  name            = "route53_logfilter"
  role_arn        = aws_iam_role.kinesis_subscription_filter_role.arn
  log_group_name  = "route53_logs"
  filter_pattern  = "testpattern"
  destination_arn = aws_kinesis_stream.route53_kinesis_stream.arn
  distribution    = "Random"
  depends_on = [
  aws_kinesis_stream.route53_kinesis_stream,
  aws_iam_role.kinesis_subscription_filter_role
  ]
}


resource "aws_kinesis_stream" "route53_kinesis_stream" {
  name             = "route53_kinesis_stream"
  shard_count      = 1
  retention_period = 30

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

}

resource "aws_iam_role" "kinesis_subscription_filter_role" {
  name = "kinesis_subscription_filter_role"
  managed_policy_arns = [aws_iam_policy.subscription_filter_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["logs.amazonaws.com",
          "kinesis.amazonaws.com"
          ]
        }
      },
    ]
  })

  }
  
  resource "aws_iam_policy" "subscription_filter_policy" {
  name        = "subscription_filter_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["logs:*", "route53:*", "kinesis:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
*/