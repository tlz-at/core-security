# Kinesis Variables
variable "kinesis_role_arn" {
  description = "Role for Firehose to use to write to the S3 bucket"
}

variable "kinesis_s3_bucket_arn" {
  description = "ARN of target S3 bucket"
}

variable "kinesis_s3_buffer_size" {
  description = "Buffer incoming data to the specified size, in MBs, before delivering it to the destination"
  default     = 5
}

variable "kinesis_s3_buffer_interval" {
  description = "Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination"
  default     = 300
}

variable "kinesis_s3_compression_format" {
  description = "The compression format; supports UNCOMPRESSED, GZIP, ZIP, or Snappy"
  default     = "GZIP"
}

# CloudWatch Variables
variable "cloudwatch_role_arn" {
  description = "Role for CloudWatch to use to write to the Firehose Stream"
}
