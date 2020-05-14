aws --region us-east-1 ec2 describe-instances --filters \
  'Name=network-interface.addresses.private-ip-address,Values=10.0.21.15' \
  --query 'Reservations[*].Instances[*].[PublicIpAddress]' \
  --output text
