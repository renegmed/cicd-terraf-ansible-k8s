
module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"
   
  name = "vpc-${var.env}"
  cidr = "10.0.0.0/16"



  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  # azs             = ["use1-az1", "use1-az2", "use1-az4"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_support = true 
  enable_dns_hostnames = true
    
  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
