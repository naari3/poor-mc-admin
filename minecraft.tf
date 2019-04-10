provider "aws" {
  region     = "${var.aws_region}"
}

resource "aws_ebs_volume" "minecraft_volume" {
  availability_zone = "ap-northeast-1a"
  type              = "gp2"
  size              = "16"

  tags {
    Name = "test_ebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdb"
  volume_id   = "${aws_ebs_volume.minecraft_volume.id}"
  instance_id = "${aws_instance.minecraft_server.id}"
}

resource "aws_security_group" "allow_all" {
  name = "allow_all"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "full open"
}

resource "aws_instance" "minecraft_server" {
  ami           = "${var.aws_ami_image}"
  instance_type = "${var.aws_ec2_instance_type}"
  key_name      = "${var.aws_ec2_key_name}"

  availability_zone = "ap-northeast-1a"

  security_groups = [
    "${aws_security_group.allow_all.name}",
  ]

  associate_public_ip_address          = "true"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = "false"
  monitoring                           = "false"

  tags = {
    Name = "minecraft"
  }
}

output "public ip" {
  value = "${aws_instance.minecraft_server.public_ip}"
}
