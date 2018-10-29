# Create the stack VPC
resource "aws_vpc" "docker" {
  cidr_block           = "${var.vpc_ip_range}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${format("%s-vpc", "${var.deployment}")}"
  }
}
