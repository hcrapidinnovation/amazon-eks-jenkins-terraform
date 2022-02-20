data "aws_ami" "rhel7_5" {
  most_recent = true

  owners = ["309956199498"] // Red Hat's account ID.

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["RHEL-7.5*"]
  }
}
resource "aws_instance" "jdk" {
  ami             = "${data.aws_ami.rhel7_5.id}"
  instance_type   = "t2.micro"
  key_name        = "${var.keyname}"
  #vpc_id          = "${aws_vpc.development-vpc.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh_jdk.id}"]
  subnet_id          = "${aws_subnet.public-subnet-1.id}"
  #name            = "${var.name}"
  user_data = "${file("install_jdk_maven.sh")}"

  associate_public_ip_address = true
  tags = {
  }
}

resource "aws_security_group" "sg_allow_ssh_jdk" {
  name        = "allow_ssh_jdk"
  description = "Allow SSH and Jdk inbound traffic"
  vpc_id      = "${aws_vpc.development-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

output "jdk_ip_address" {
  value = "${aws_instance.jdk.public_dns}"
}
