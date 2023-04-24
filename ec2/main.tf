module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.3.0"

  name = var.name

  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  monitoring                  = var.monitoring
  create_iam_instance_profile = var.create_iam_instance_profile
  iam_role_description        = var.iam_role_description #"IAM role for EC2 instance"
  iam_role_policies           = var.iam_role_policies
  iam_instance_profile        = var.iam_instance_profile
  enable_volume_tags          = var.enable_volume_tags
  root_block_device           = var.root_block_device
  ebs_block_device            = var.ebs_block_device
  tags                        = var.tags
}


resource "aws_ec2_instance_state" "ec2_instance_state" {
  instance_id = module.ec2_instance.id
  state       = var.state
}
