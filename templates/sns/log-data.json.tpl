{
  "Version":"2012-10-17",
  "Statement":
  [
    {
      "Sid": "s3_publish",
      "Effect": "Allow",
      "Principal": {
        "AWS":"*"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:eu-west-2:${account_id}:${sns_topic_name}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn":"arn:aws:s3:::*"
        },
        "StringEquals": {
          "aws:SourceAccount": "${account_id}"
        }
      }
    },
    {
      "Sid": "lambda_subscribe",
      "Effect": "Allow",
      "Principal": {
        "AWS":"*"
      },
      "Action": "SNS:Subscribe",
      "Resource": "arn:aws:sns:eu-west-2:${account_id}:${sns_topic_name}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn":"arn:aws:lambda:eu-west-2:${account_id}:function:log-data-*"
        }
      }
    }
  ]
}
