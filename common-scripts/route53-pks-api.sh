aws --region us-east-1 ec2 describe-instances --filters 'Name=private-ip-address,Values=10.0.1.11' --query 'Reservations[*].Instances[*].[PublicIpAddress]' --output text
