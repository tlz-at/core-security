# Set up the role for CloudWatch to write to Firehose
resource "aws_iam_role" "cloudwatch_firehose_guardduty_role" {
  name               = "tlz_cloudwatch_firehose_guardduty"
  assume_role_policy = "${data.aws_iam_policy_document.cloudwatch_firehose_guardduty_assume_policy.json}"
}

data "aws_iam_policy_document" "cloudwatch_firehose_guardduty_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "tlz_cloudwatch_firehose_guardduty_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [
      "arn:aws:firehose:us-east-2:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ap-northeast-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ap-northeast-2:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ap-south-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ap-southeast-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ap-southeast-2:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:ca-central-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:eu-central-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:eu-west-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:eu-west-2:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:eu-west-3:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:sa-east-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:us-east-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:us-west-2:${var.account_id}:deliverystream/guardduty-firehose-stream",
      "arn:aws:firehose:us-west-1:${var.account_id}:deliverystream/guardduty-firehose-stream",
    ]
  }
}

resource "aws_iam_policy" "tlz_cloudwatch_firehose_guardduty_role_policy" {
  name   = "tlz_cloudwatch_firehose_guardduty_role_policy"
  policy = "${data.aws_iam_policy_document.tlz_cloudwatch_firehose_guardduty_role_policy.json}"
}

resource "aws_iam_policy_attachment" "tlz_cloudwatch_firehose_guardduty_role_policy" {
  name       = "tlz_cloudwatch_firehose_guardduty_role_policy"
  roles      = ["${aws_iam_role.cloudwatch_firehose_guardduty_role.name}"]
  policy_arn = "${aws_iam_policy.tlz_cloudwatch_firehose_guardduty_role_policy.arn}"
}

# Set up the primary region
module "guardduty_firehose_stream_us_west_2" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.us-west-2"
  }
}

# Set up all other regions
module "guardduty_firehose_stream_ap_northeast_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ap-northeast-1"
  }
}

module "guardduty_firehose_stream_ap_northeast_2" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ap-northeast-2"
  }
}

module "guardduty_firehose_stream_ap_south_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ap-south-1"
  }
}

module "guardduty_firehose_stream_ap_southeast_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ap-southeast-1"
  }
}

module "guardduty_firehose_stream_ap_southeast_2" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ap-southeast-2"
  }
}

module "guardduty_firehose_stream_ca_central_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.ca-central-1"
  }
}

module "guardduty_firehose_stream_eu_central_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.eu-central-1"
  }
}

module "guardduty_firehose_stream_eu_west_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.eu-west-1"
  }
}

module "guardduty_firehose_stream_eu_west_2" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.eu-west-2"
  }
}

module "guardduty_firehose_stream_eu_west_3" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.eu-west-3"
  }
}

module "guardduty_firehose_stream_sa_east_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.sa-east-1"
  }
}

module "guardduty_firehose_stream_us_east_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.us-east-1"
  }
}

module "guardduty_firehose_stream_us_east_2" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.us-east-2"
  }
}

module "guardduty_firehose_stream_us_west_1" {
  source = "modules/guardduty-firehose-stream"

  kinesis_role_arn              = "${local.firehose_guardduty_role_arn}"
  kinesis_s3_bucket_arn         = "${local.s3_guardduty_logs_bucket_arn}"
  kinesis_s3_buffer_size        = "${var.kinesis_s3_buffer_size}"
  kinesis_s3_buffer_interval    = "${var.kinesis_s3_buffer_interval}"
  kinesis_s3_compression_format = "${var.kinesis_s3_compression_format}"
  cloudwatch_role_arn           = "${aws_iam_role.cloudwatch_firehose_guardduty_role.arn}"

  providers = {
    aws = "aws.us-west-1"
  }
}
