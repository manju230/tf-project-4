output "bucket_name" {
  value = aws_s3_bucket.project_s3.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.project_s3.id
}

output "bucket_arn" {
  value = aws_s3_bucket.project_s3.arn
}
