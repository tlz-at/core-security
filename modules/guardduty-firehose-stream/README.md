# guardduty-firehose-stream
Creates the related components for the Master GuardDuty detector and Firehose Stream to a central S3 bucket

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cloudwatch\_role\_arn | Role for CloudWatch to use to write to the Firehose Stream | string | - | yes |
| kinesis\_role\_arn | Role for Firehose to use to write to the S3 bucket | string | - | yes |
| kinesis\_s3\_bucket\_arn | ARN of target S3 bucket | string | - | yes |
| kinesis\_s3\_buffer\_interval | Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination | string | `300` | no |
| kinesis\_s3\_buffer\_size | Buffer incoming data to the specified size, in MBs, before delivering it to the destination | string | `5` | no |
| kinesis\_s3\_compression\_format | The compression format; supports UNCOMPRESSED, GZIP, ZIP, or Snappy | string | `GZIP` | no |
