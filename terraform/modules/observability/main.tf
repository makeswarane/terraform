resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "AppMonitoringDashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6
        properties = {
          region = "ap-south-1"
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "i-xxxxxx"]
          ]
          period = 300
          stat   = "Average"
          title  = "EC2 CPU Utilization"
        }
      }
    ]
  })
}
