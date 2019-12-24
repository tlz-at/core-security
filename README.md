# core-security-guardduty
Centralized GuardDuty

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | The ID of the working account | string | - | yes |
| kinesis\_s3\_buffer\_interval | Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination | string | `300` | no |
| kinesis\_s3\_buffer\_size | Buffer incoming data to the specified size, in MBs, before delivering it to the destination | string | `5` | no |
| kinesis\_s3\_compression\_format | The compression format; supports UNCOMPRESSED, GZIP, ZIP, or Snappy | string | `GZIP` | no |
| name | Name of the account | string | - | yes |
| region | AWS Region to deploy to | string | `us-east-2` | no |
