module "fsx_lustre" {
  source = "../modules/fsx"  

  name                       = "fsx-lustre-prod"
  region                     = "us-east-1"
  vpc_id                     = "vpc-0123456789abcdef0"
  subnet_ids                 = ["subnet-0aaa1111", "subnet-0bbb2222"]
  security_group_ids         = ["sg-0123abcd4567efgh8"]
  kms_key_id                 = "arn:aws:kms:us-east-1:123456789012:key/abcde-1234-5678-9101-abcdef123456"

  deployment_type            = "PERSISTENT_1"
  storage_capacity           = 2400
  storage_type               = "SSD"
  per_unit_storage_throughput = 200
  data_compression_type      = "LZ4"

  data_repository_path       = "s3://my-fsx-lustre-bucket/prod"
  file_system_path           = "/"

  s3 = {
    auto_import_policy = ["NEW", "CHANGED"]
    auto_export_policy = ["NEW", "CHANGED", "DELETED"]
  }

  tags = {
    Environment = "prod"
    Team        = "data-platform"
    Project     = "genomics-analysis"
    Owner       = "anurag.parchuri"
  }
}
