# Get identity and region
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Enable GuardDuty
# resource "aws_guardduty_detector" "master" {
#   enable = true
# }

# Create a Kinesis Firehose delivery stream for GuardDuty
resource "aws_kinesis_firehose_delivery_stream" "firehose_guardduty" {
  name        = "guardduty-firehose-stream"
  destination = "s3"

  s3_configuration {
    role_arn           = "${var.kinesis_role_arn}"
    bucket_arn         = "${var.kinesis_s3_bucket_arn}"
    buffer_size        = "${var.kinesis_s3_buffer_size}"
    buffer_interval    = "${var.kinesis_s3_buffer_interval}"
    compression_format = "${var.kinesis_s3_compression_format}"
  }
}

# Cloudwatch Event Rule
resource "aws_cloudwatch_event_rule" "guardduty" {
  name        = "guardduty_sent_to_firehose"
  description = "Send GuardDuty Events to Firehose"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.guardduty"
  ]
}
PATTERN
}

# Cloudwatch Rule Target
resource "aws_cloudwatch_event_target" "firehose" {
  rule      = "${aws_cloudwatch_event_rule.guardduty.name}"
  target_id = "SendtoFirehose"
  arn       = "${aws_kinesis_firehose_delivery_stream.firehose_guardduty.arn}"
  role_arn  = "${var.cloudwatch_role_arn}"
}
