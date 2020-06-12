terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "k8s-backend"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}