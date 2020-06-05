terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "mateus-backend"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}