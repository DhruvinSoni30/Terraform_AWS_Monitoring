# Fetching AWS Key Pair
data "aws_key_pair" "demoKey" {
  key_name           = var.keyName
  include_public_key = true
}