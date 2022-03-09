resource "aws_cloudwatch_composite_alarm" "EC2_and_EBS" {
  alarm_description = "Composite alarm that monitors CPUUtilization and EBS Volume Read Operations"
  alarm_name        = "EC2_&EBS_Composite_Alarm"
  alarm_actions = [aws_sns_topic.EC2_and_EBS_topic.id]

  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EBS_ReadOperations.alarm_name})"


  depends_on = [
    aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm,
    aws_cloudwatch_metric_alarm.EBS_ReadOperations,
    aws_sns_topic.EC2_and_EBS_topic,
    aws_sns_topic_subscription.EC2_and_EBS_Subscription
  ]
}


resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
  alarm_name          = "EC2_CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization exceeding 70%"
}


resource "aws_cloudwatch_metric_alarm" "EBS_ReadOperations" {
  alarm_name          = "EBS_ReadOperations"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "VolumeReadOps"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1000"
  alarm_description   = "This monitors the average read operations on EBS Volumes in a specified period of time"
}


resource "aws_sns_topic" "EC2_and_EBS_topic" {
  name = "EC2_and_EBS_topic"
}

resource "aws_sns_topic_subscription" "EC2_and_EBS_Subscription" {
  topic_arn = aws_sns_topic.EC2_and_EBS_topic.arn
  protocol  = "email"
  endpoint  = "kelvingalabuzi@gmail.com"

  depends_on = [
    aws_sns_topic.EC2_and_EBS_topic
  ]
}
