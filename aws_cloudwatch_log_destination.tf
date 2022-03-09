resource "aws_iam_role" "cloudwatch_log_destination_role" {
  name = "cloudwatch_log_destination_role"
  managed_policy_arns = [aws_iam_policy.cloudwatch_log_destination_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
          "logs.amazonaws.com"
          ]
        
        }
      },
    ]
   })
  }
  
  resource "aws_iam_policy" "cloudwatch_log_destination_policy" {
  name        = "cloudwatch_log_destination_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["logs:*", "kinesis:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_kinesis_stream" "Kinesis_stream" {
  name             = "Kinesis_stream"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

}

resource "aws_cloudwatch_log_destination" "EC2_log_destination" {
  name       = "EC2_log_destination"
  role_arn   = aws_iam_role.cloudwatch_log_destination_role.arn
  target_arn = aws_kinesis_stream.Kinesis_stream.arn
  depends_on = [
    aws_iam_role.cloudwatch_log_destination_role,
    aws_kinesis_stream.Kinesis_stream
  ]
}