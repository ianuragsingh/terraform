provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      "sph:env"         = var.env
      "sph:app-tier"    = "2"
      "sph:appteam"     = "mlops"
      "sph:cost-centre" = "1691"
      "sph:product"     = var.project_name
      "sph:biz-dept"    = "CDE"
      map-migrated      = "d-server-00fyc0pr7gc8hv"
    }
  }
}