/*resource "aws_cloudwatch_log_metric_filter" "ElasticBeanStalk_metric_filter" {
  name           = "ElasticBeanStalk_metric_filter"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.ElasticBeanStalk_log_group.name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "ElasticBeanstalk"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_group" "ElasticBeanStalk_log_group" {
  name = "ElasticBeanStalk_log_group"
}
*/