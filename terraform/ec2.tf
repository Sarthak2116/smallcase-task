resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "smallcase"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "smallcase"
  }
}

resource "aws_network_interface" "sc_ni" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "sc_test" {
  ami           = "ami-0851b76e8b1bce90b"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.sc_ni.id
    device_index         = 0
  }
  launch_template {
    name = aws_launch_template.sc_lt.name
  }
}