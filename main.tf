terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "Jmeter_server" {
  ami               = var.aws_ami
  instance_type     = var.aws_instance_type
  tags = {
    Name = "Santhosh_AWS_JMeter_Server"
  }
  user_data = templatefile("${path.module}/install_jmeter.sh", {
    JMETER_HOME                         = var.jmeter_home,
    JMETER_VERSION                      = var.jmeter_version,
    JMETER_DOWNLOAD_URL                 = "https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${var.jmeter_version}.tgz",
    JMETER_CMDRUNNER_VERSION            = var.jmeter_cmdrunner_version,
    JMETER_CMDRUNNER_DOWNLOAD_URL       = "http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${var.jmeter_cmdrunner_version}/cmdrunner-${var.jmeter_cmdrunner_version}.jar",
    JMETER_PLUGINS_MANAGER_VERSION      = var.jmeter_plugins_manager_version,
    JMETER_PLUGINS_MANAGER_DOWNLOAD_URL = "https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${var.jmeter_plugins_manager_version}/jmeter-plugins-manager-${var.jmeter_plugins_manager_version}.jar",
    JMETER_PLUGINS                      = join(",", var.jmeter_plugins)
  })
}
