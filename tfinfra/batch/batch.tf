## Make sure your Subnet has internet access

## Just use the default vpc and subnet - they have internet access
variable "subnet" {
  default = "subnet-1bc2ad40"
}

variable "vpc" {
  default = "vpc-ce78f4a8"
}


provider "aws" {
  region     = "us-west-2"
}

data "aws_vpc" "sample" {
  id = "${var.vpc}"
}

data "aws_subnet" "sample" {
  id = "${var.subnet}"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "t_ecs_instance_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "ec2.amazonaws.com"
        }
    }
    ]
}
EOF
}

## This policy is CRITICAL - without this no container service and therefor things get stuck
resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "t_ecs_instance_role"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role" "aws_batch_service_role" {
  name = "t_aws_batch_service_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "batch.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = "${aws_iam_role.aws_batch_service_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_security_group" "sample" {
  name = "t_aws_batch_compute_environment_security_group"
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_batch_compute_environment" "sample" {
  compute_environment_name = "t_sample"

  compute_resources {
    instance_role = "${aws_iam_instance_profile.ecs_instance_role.arn}"

    instance_type = [
      "optimal",
    ]

    max_vcpus = 24
    # min_vcpus = 4
    # desired_vcpus = 4
    min_vcpus = 0
    desired_vcpus = 0

    security_group_ids = [
      "${aws_security_group.sample.id}",
    ]
    
    ec2_key_pair = "bucketlauncher2-keypair"

    subnets = [
      "${data.aws_subnet.sample.id}",
    ]

    type = "EC2"
  }

  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type         = "MANAGED"
  depends_on   = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}

resource "aws_batch_job_queue" "this" {
  name = "t_job-queue"
  state = "ENABLED"
  priority = "1"
  compute_environments = [
    "${aws_batch_compute_environment.sample.arn}",
  ]
}

resource "aws_batch_job_definition" "example" {
  name = "t_this-job-definition"
  type = "container"
  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["echo", "Hello World"],
    "image": "busybox",
    "memory": 120,
    "vcpus": 1,
    "environment": [
        {"name": "EXAMPLE_KEY", "value": "EXAMPLE_VALUE"}
    ]
}
CONTAINER_PROPERTIES
}


resource "aws_batch_job_definition" "test" {
  name = "t_this-job-definition2"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["ls", "-la"],
    "image": "busybox",
    "memory": 120,
    "vcpus": 1,
    "volumes": [
      {
        "host": {
          "sourcePath": "/tmp"
        },
        "name": "tmp"
      }
    ],
    "environment": [
        {"name": "VARNAME", "value": "VARVAL"}
    ],
    "mountPoints": [
        {
          "sourceVolume": "tmp",
          "containerPath": "/tmp",
          "readOnly": false
        }
    ],
    "ulimits": [
      {
        "hardLimit": 1024,
        "name": "nofile",
        "softLimit": 1024
      }
    ]
}
CONTAINER_PROPERTIES
}
