terraform {
  backend "s3" {
    bucket = "acklen-terraform-state"
    key    = "glee-backend"
    region = "us-east-1"
  }
}