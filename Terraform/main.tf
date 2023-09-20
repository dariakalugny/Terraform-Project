
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16"
    }
  }

  required_version = ">= 1.0.0"
}


resource "aws_elastic_beanstalk_application" "Project-game-2048" {
  name        = var.name
  description = "Project-game-2048-daria-shani"

}



resource "aws_elastic_beanstalk_application_version" "Project-game-2048" {
  name        = "1.0"
  application = var.name
  description = "application version"
  bucket      = "project-daria-shani"
  key         = "2048/Dockerfile"
}




resource "aws_elastic_beanstalk_environment" "Application2048-daria-shani" {
  name                = var.name
  application         = aws_elastic_beanstalk_application.Project-game-2048.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.1 running Docker"
  version_label       = aws_elastic_beanstalk_application_version.Project-game-2048.name



  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-0d37ae25adc984356"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-0eb0c47b5d27e872e"
  }

   setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-05deba43835a0d6c9"
  }

    setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "ElasticBeanstalkApp"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }


   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }
   setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
   setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

   setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "project-daria-shani"
    value     = "s3://project-daria-shani/2048/Dockerfile/"
  }




}