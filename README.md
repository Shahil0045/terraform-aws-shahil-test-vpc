# terraform-aws-vpc

## Overview

This terraform module creates an AWS VPC with a given CIDR block. ti also creates multiple subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables.

## Features

- Creates a VPC with a specified CIDR block 
- Creates public and private subnets
- Creates an Internet Gateway (IGW) for public subnets
- Sets up route tables for public subnets

## Usage

```
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
    source = "./module/vpc"

    vpc_config = {
        vpc_name   = "my-custom-vpc"
        cidr_block = "10.0.0.0/16"
    }
    subnet_config = {
        public_subnet = {
            cidr_block        = "10.0.0.0/24"
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