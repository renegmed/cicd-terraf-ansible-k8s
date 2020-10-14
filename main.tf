 
module "main-vpc" {
  source     = "./modules/vpc"
  env        = "dev"
  region = var.region  
}


module "k8s" {
  source          = "./modules/k8s"
  env             = "dev"
  region          = var.region
  ami             = var.ami 
  instance_type   = var.instance_type
  vpc_id          = module.main-vpc.vpc_id         # value came from output value of modules/vpc 
  public_subnet_id = module.main-vpc.public_subnets[0] # value came from output value of modules/vpc 
  security_group  = module.main-vpc.security_group
  k8s_role_name   = module.main-vpc.k8s_role_name
}


module "ansible" {
  source            = "./modules/ansible"
  env               = "dev"
  region            = var.region
  ami               = var.ami 
  instance_type     = var.instance_type
  vpc_id            = module.main-vpc.vpc_id         # value came from output value of modules/vpc 
  public_subnet_id  = module.main-vpc.public_subnets[1] # value came from output value of modules/vpc 
  security_group    = module.main-vpc.security_group
  ansible_instance_count = "1"
  ansible_user      = "ansadmin"
  ansible_password  = "password123"  
}


module "jenkins" {
  source         = "./modules/jenkins"
  region = var.region
  env            = "dev"
  vpc_id         = module.main-vpc.vpc_id         # value came from output value of modules/vpc 
  public_subnet_id = module.main-vpc.public_subnets[2] # value came from output value of modules/vpc 
  security_group = module.main-vpc.security_group 
  availability_zone = module.main-vpc.availability_zones[0]
  jenkins_role_name  = module.main-vpc.k8s_role_name
}