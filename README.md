# Creating Infrastructure on AWS and monitoring solutions using Terraform Modules

* Cloudwatch alarm is used to monitor a single cloud watch metric or the result of Match expression using cloud watch metrics. Also, it sends out a notification based on the threshold we set for each service in the cloud watch alarm. You can actively monitor the status of each alarm in the cloud watch dashboard.
  
* Amazon Simple Notification Service (Amazon SNS) is a managed service that provides message delivery from publishers to subscribers (also known as producers and consumers). Publishers communicate asynchronously with subscribers by sending messages to a topic, which is a logical access point and communication channel. Clients can subscribe to the SNS topic and receive published messages using a supported endpoint type, such as Amazon Kinesis Data Firehose, Amazon SQS, AWS Lambda, HTTP, email, mobile push notifications, and mobile text messages (SMS).

![workflow](https://github.com/DhruvinSoni30/Terraform_AWS_Monitoring/blob/main/images/workflow.jpeg)
