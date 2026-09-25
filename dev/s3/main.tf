resource "aws_s3_bucket" "project_s3" {
    bucket = "tf-project-3-lab-2026"
    tags = local.common_tags
}
