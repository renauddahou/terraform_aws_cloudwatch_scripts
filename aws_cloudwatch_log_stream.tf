resource "aws_cloudwatch_log_group" "ebs_log_group" {
  name = "ebs_log_group"
}

resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
  name           = "ebs_log_stream"
  log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
}
