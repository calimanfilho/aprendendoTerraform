module "network" {
  # source      = "github/com/calimanfilho/terraform-network?ref=1.0.0"
  source      = "./modules/network"
  owner       = local.owner
  environment = local.env
  region      = lookup(var.aws_region, local.env)
}

module "frontend" {
  # source      = "github/com/calimanfilho/terraform-frontend?ref=1.0.0"
  source      = "./modules/frontend"
  region      = lookup(var.aws_region, local.env)
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
}

module "backend" {
  # source      = "github/com/calimanfilho/terraform-backend?ref=1.0.0"
  source      = "./modules/backend"
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
}

module "database" {
  # source      = "github/com/calimanfilho/terraform-database?ref=1.0.0"
  source      = "./modules/database"
  engine      = "postgres"
  storage     = 10
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
  db_username = "foo"
  db_password = "passwordfoo"
}