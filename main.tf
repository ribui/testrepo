# provisioning vpc for the frontend and backend application
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# provisioning subnet for the frontend and backend application
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_subnet"
  }
}

# provisioning internet_gateway for frontend and backend application
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}

# provisioning routing table for frontend and backend application
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.my_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# provisioning security_group for frontend and backend application
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow inbound traffic on port 8080 and 3000"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# provisioning ecr_repository for frontend and backend application
resource "aws_ecr_repository" "my_ecr_repository" {
  name = "my-ecr-repository"
}

# PROVISIONING ECS CLUSTER SERVICE AND TASK DEFINATION 

# provisioning a cluster for frontend and backend application
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}


# provisioning IAM role for the ECR
resource "aws_iam_role" "ecs_role" {
  name = "my_node_app_iam"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attaching the IAM role to the ECR
resource "aws_iam_role_policy_attachment" "ecs_policy_attachment" {
  role = aws_iam_role.ecs_role.name

  // This policy adds logging + ecr permissions
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Provisioning Backend task_defination for the backend
resource "aws_ecs_task_definition" "backend_task" {
  family = "backend_example_app_family"

  // Fargate is a type of ECS that requires awsvpc network_mode
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  // Valid sizes are shown here: https://aws.amazon.com/fargate/pricing/
  memory = "512"
  cpu    = "256"

  // Fargate requires task definitions to have an execution role ARN to support ECR images
  execution_role_arn = aws_iam_role.ecs_role.arn

  container_definitions = <<EOT
[
    {
        "name": "frontend_app_container",
        "image": "160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test@sha256:d686a9d8bd2f4c1b47faffaf6ac33aec3a63f76c5511e71195772914179d23fc",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 3000,
                "hostPort": 3000
            }
        ]
    },
  {
        "name": "backend_app_container",
        "image": "160503865246.dkr.ecr.us-east-1.amazonaws.com/docker-test:latest",
        "memory": 512,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 8080,
                "hostPort": 8080
            }
        ]
    }
]
EOT
}



# provisioning ecs_service for backend and frontend application 
resource "aws_ecs_service" "backend_service" {
  name = "backend_service"

  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn

  launch_type   = "FARGATE"
  desired_count = 1

  network_configuration {
    subnets          = [aws_subnet.my_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }
}
