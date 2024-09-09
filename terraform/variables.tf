variable "instance_name" {
    description = "Name of the instance"
    default = "conduit-tf"
}

variable "ami_id" {
    description = "Ubuntu AMI"
    value = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
    description = "Instance type"
    value = "t2.micro"
}

variable "key_name" {
    description = "Name of Keypair"
    value = "conduit-app-key" 
}

variable "userdata_script" {
    description = "Script to be executed by userdata"
    value = "./setup.sh"
}

variable "region" {
    description = "Region"
    value = "us-east-1"
}