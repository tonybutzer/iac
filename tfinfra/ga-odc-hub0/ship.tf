/* this is a multi
comment */

provider "aws" {
  region = "${var.region}"
}


resource "aws_instance" "ga-odc-hub0" {

  ami           = "${var.ami}"

  instance_type = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  tags {
    Name = "ga-odc-hub0"
    Owner = "tonybutzer@gmail.com"
  }
  iam_instance_profile                    ="${var.iam_role}"
  security_groups = ["${var.security_group}"]
  user_data                   = "${file("files/os_boot.sh")}"
  root_block_device {volume_size = 30}
}
