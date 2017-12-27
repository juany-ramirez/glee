terraform {
  backend "s3" {
    bucket = "acklen-terraform-state"
    key    = "glee-backend/ecs"
    region = "us-east-1"
  }
}