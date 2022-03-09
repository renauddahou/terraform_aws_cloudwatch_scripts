resource "aws_launch_template" "EC2_Launch_Template" {
  name_prefix   = "EC2-Launch-Template"
  image_id      = "ami-0f540030bb04d884a"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "EC2_AutoScaling_Group" {
  availability_zones = ["us-east-2b"]
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1

  launch_template {
    id      = aws_launch_template.EC2_Launch_Template.id
    version = "$Latest"
  }
  depends_on = [
    aws_launch_template.EC2_Launch_Template,
  ]
}


resource "aws_autoscaling_policy" "EC2_AutoScaling_Policy" {
  name                   = "EC2-AutoScaling-Policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.EC2_AutoScaling_Group.name
  depends_on = [
    aws_autoscaling_group.EC2_AutoScaling_Group,
  ]
}

resource "aws_cloudwatch_metric_alarm" "EC2_metric_alarm" {
  alarm_name          = "EC2-metric-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"
  depends_on = [
    aws_autoscaling_group.EC2_AutoScaling_Group,
  ]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.EC2_AutoScaling_Group.name
  }
  

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.EC2_AutoScaling_Policy.arn]
}
