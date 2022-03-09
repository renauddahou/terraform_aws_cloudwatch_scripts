/*resource "aws_cloudwatch_log_destination" "demo_destination" {
  name       = "test_destination"
  role_arn   = aws_iam_role.cloudwatch_log_destination_demo_role.arn
  target_arn = aws_kinesis_stream.demo_kinesis_stream.arn
}

data "aws_iam_policy_document" "demo_destination_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "123456789012",
      ]
    }

    actions = [
      "logs:PutSubscriptionFilter",
    ]

    resources = [
      aws_cloudwatch_log_destination.demo_destination.arn,
    ]
  }
}

resource "aws_kinesis_stream" "demo_kinesis_stream" {
  name             = "demo_kinesis_stream"
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

resource "aws_iam_role" "cloudwatch_log_destination_demo_role" {
  name = "cloudwatch_log_destination_demo_role"
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

resource "aws_cloudwatch_log_destination_policy" "demo_destination_policy" {
  destination_name = aws_cloudwatch_log_destination.demo_destination.name
  access_policy    = data.aws_iam_policy_document.demo_destination_policy.json
}
*/