variable "APPNAME" {}
variable "SUBNETS" {
  type    = "map"
  default = {
    "10.0.0.0/20" = ["us-east-1a","public"]
    "10.0.16.0/20" = ["us-east-1a","private"]
    "10.0.32.0/20" = ["us-east-1b","public"]
    "10.0.48.0/20" = ["us-east-1b","private"]
    "10.0.64.0/20" = ["us-east-1c","public"]
    "10.0.80.0/20" = ["us-east-1c","private"]
    "10.0.96.0/20" = ["us-east-1d","public"]
    "10.0.112.0/20" = ["us-east-1d","private"]
  }
}