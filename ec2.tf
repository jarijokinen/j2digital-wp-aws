resource "aws_launch_template" "wp" {
  image_id               = "ami-01324684792f591ee"
  instance_type          = "t4g.micro"
  vpc_security_group_ids = [aws_security_group.wp.id]
  user_data              = base64encode(
    <<-EOT
      #!/bin/bash
      echo ECS_CLUSTER=wp >> /etc/ecs/ecs.config
    EOT
  )

  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = true
      volume_size           = 8
      volume_type           = "gp3"
    }
  }
}
