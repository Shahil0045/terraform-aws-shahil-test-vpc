This is complete config to work with this module

USAGE
```
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
    source = "Shahil0045/shahil-test-vpc/aws"

    vpc_config = {
        vpc_name   = "my-custom-vpc"
        cidr_block = "10.0.0.0/16"
    }
    subnet_config = {
        public_subnet_1 = {
            cidr_block        = "10.0.0.0/24"
            availability_zone = "ap-south-1a" 
            public = true
        }

        public_subnet_2 = {
            cidr_block        = "10.0.1.0/24"
            availability_zone = "ap-south-1a" 
            public = true
        }

        private_subnet = {
            cidr_block        = "10.0.2.0/24"
            availability_zone = "ap-south-1b"
        }
    }
}
```