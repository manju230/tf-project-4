output "vpc_id" {
    value = data.aws_vpc.main.id
}

output "subnet_id" {
    value = data.aws_subnet.app_a.id
}

output "instance_id" {
    value = aws_instance.app_server.id
}

output "private_ip" {
    value = aws_instance.app_server.private_ip
}