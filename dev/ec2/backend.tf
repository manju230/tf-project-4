terraform {
 backend "s3" {
   bucket = "terraform-s3-backend-prod-tfstate-us"
   key = "tf-project-4/ec2.tfstate"
   region = "us-east-1"
   encrypt = true
 }
}