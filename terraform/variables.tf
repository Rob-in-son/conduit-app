variable "instance_name" {
    description = "Name of the instance"
    default = "conduit-tf"
}

variable "ami_id" {
    description = "Ubuntu AMI"
    default = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
    description = "Instance type"
    default = "t2.micro"
}

variable "key_name" {
    description = "Name of Keypair"
    default = "conduit-app-key" 
}

# variable "userdata_script" {
#     description = "Script to be executed by userdata"
#     default = "./setup.sh"
# }

variable "region" {
    description = "Region"
    default = "us-east-1"
}