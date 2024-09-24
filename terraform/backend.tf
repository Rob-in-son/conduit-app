terraform {
    backend "s3" {
        bucket =  "conduit-terraform-state"
        key = "conduit-terraform-state"
        region =  "us-east-1"
    }
}