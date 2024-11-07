resource "random_id" "bucket_suffix" {
  byte_length = var.random_suffix_length
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket        = "${var.s3_bucket_name}-${random_id.bucket_suffix.hex}"
    tags          = var.tags
    force_destroy = var.force_destroy
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket        = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
    bucket        = aws_s3_bucket.s3_bucket.id
    acl           = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
    bucket        = aws_s3_bucket.s3_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket        = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_block_public_access" {
  bucket        = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


## Cloudwatch Alarms and Metrics Dashboard 
resource "aws_sns_topic" "cloudwatch_notifications" {
  count = var.cloudwatch_resources ? 1 : 0
  name  = var.sns_topic_name
}

resource "aws_cloudwatch_metric_alarm" "s3_bucket_size_alarm" {
  count               = var.cloudwatch_resources ? 1 : 0
  alarm_name          = "S3BucketSizeAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BucketSizeBytes"
  namespace           = "AWS/S3"
  period              = 3600
  statistic           = "Average"
  threshold           = var.s3_bucket_size_threshold
  alarm_description   = "Alarm when S3 bucket size exceeds."
  alarm_actions       = var.cloudwatch_resources ? [aws_sns_topic.cloudwatch_notifications[0].arn] : []
  dimensions = {
    BucketName = aws_s3_bucket.s3_bucket.bucket
  }
  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_cloudwatch_metric_alarm" "s3_number_of_objects_alarm" {
  count               = var.cloudwatch_resources ? 1 : 0
  alarm_name          = "S3NumberOfObjectsAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfObjects"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Sum"
  threshold           = var.s3_number_of_objects_threshold
  alarm_description   = "Alarm when number of objects in S3 bucket exceeds."
  alarm_actions       = var.cloudwatch_resources ? [aws_sns_topic.cloudwatch_notifications[0].arn] : []
  dimensions = {
    BucketName = aws_s3_bucket.s3_bucket.bucket
  }
  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_cloudwatch_dashboard" "s3_dashboard" {
  count          = var.cloudwatch_resources ? 1 : 0
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    #S3 Metrics
    "widgets" : [
      {
        "type" : "metric",
        "x" : 0,
        "y" : 0,
        "width" : 6,
        "height" : 6,
        "properties" : {
          "view" : "timeSeries",
          "title" : "S3 BucketSizeBytes",
          "stacked" : false,
          "metrics" : [
            ["AWS/S3", "BucketSizeBytes", "BucketName", "${aws_s3_bucket.s3_bucket.bucket}"]
          ],
          "region" : "${var.region}"
        }
      },
      {
        "type" : "metric",
        "x" : 6,
        "y" : 0,
        "width" : 6,
        "height" : 6,
        "properties" : {
          "view" : "timeSeries",
          "title" : "S3 NumberOfObjects",
          "stacked" : false,
          "metrics" : [
            ["AWS/S3", "NumberOfObjects", "BucketName", "${aws_s3_bucket.s3_bucket.bucket}"]
          ],
          "region" : "${var.region}"
        }
      }
    ]
  })
  depends_on = [aws_s3_bucket.s3_bucket]
}
