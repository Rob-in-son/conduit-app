resource "aws_instance" "conduit-tf" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.conduit-app-sg.id]
    # user_data = templatefile(var.userdata_script, {})

    tags = {
        Name = "conduit-tf"
    }
}

# resource "ansible_host" "conduit-tf" {
#     # ansible host details
#     name = aws_instance.conduit-tf.public_dns
#     groups = ["ansible_client"]
#     variables = {
#         ansible_user = "ubuntu"
#         ansible_ssh_private_key_file = "~/.ssh/conduit-app-key.pem"
#         ansible_python_interpreter = "/opt/homebrew/bin/python3"
#     }
# }

resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [conduit-tf]
    ${aws_instance.conduit-tf.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/conduit-app-key.pem
  EOT
  filename = "../ansible/inventory.ini"

  depends_on = [aws_instance.conduit-tf]
}

resource "null_resource" "wait_for_instance" {
  provisioner "local-exec" {
    command = "sleep 60" 
  }

  depends_on = [aws_instance.conduit-tf]
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini main.yml -e 'env=dev' --ask-vault-pass -v"
    working_dir = "../ansible"
  }

  depends_on = [
    local_file.ansible_inventory,
    aws_instance.conduit-tf,
    null_resource.wait_for_instance
  ]
}

output "ip" {
    value = "${aws_instance.conduit-tf.public_ip}"
}