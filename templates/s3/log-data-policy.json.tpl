{
  "Id": "secure-logging-${bucket_name}",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowOtherAccounts",
      "Action": "s3:*",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${external_account_1}:role/${role_name_intg}",
          "arn:aws:iam::${external_account_2}:role/${role_name_staging}",
          "arn:aws:iam::${external_account_3}:role/${role_name_prod}"
        ]
      },
      "Resource": [
        "arn:aws:s3:::${bucket_name}",
        "arn:aws:s3:::${bucket_name}/*"
      ]
    },
    {
      "Sid": "AWSLogDeliveryWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${bucket_name}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${bucket_name}"
    }
  ]
}
