locals {
  prefix = "mumbai-vpc"

  comman_tags = {
    Project     = "Enterprise"
    Environment = "Development"
    Owner       = "Manjunath"
    Team        = "Cloud"
    Managedby   = "Terraform"
    Location    = "NA"
    BU          = "Finance"
  }

  az_map = {
    "ap-south-1a" = "az1"
    "ap-south-1b" = "az2"
    "ap-south-1c" = "az3"
  }
}
