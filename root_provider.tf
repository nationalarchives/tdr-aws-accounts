provider "aws" {
  region = "eu-west-2"

  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-northeast-3"
  region = "ap-northeast-3"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "eu-north-1"
  region = "eu-north-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
    external_id  = module.global_parameters.external_ids.terraform_environments
  }
}
