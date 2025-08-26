output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

locals {
    public_subnet_output = {
        for key, config in local.public_subnet : key => {
            subnet_id = aws_subnet.main[key].id
            availability_zone = aws_subnet.main[key].availability_zone
        }
    }

    private_subnet_output = {
        for key, config in local.private_subnet : key => {
            subnet_id = aws_subnet.main[key].id
            availability_zone = aws_subnet.main[key].availability_zone
        } if !lookup(var.subnet_config[key], "public", false)
    }
}

output "public_subnets" {
  description = "A map of public subnet IDs and their availability zones"
  value       = local.public_subnet_output
}

output "private_subnets" {
  description = "A map of private subnet IDs and their availability zones"
  value       = local.private_subnet_output
}