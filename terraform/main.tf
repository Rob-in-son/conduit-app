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

resource "ansible_host" "conduit-tf" {
    # ansible host details
    name = aws_instance.conduit-tf.public_dns
    groups = ["ansible_client"]
    variables = {
        ansible_user = "uche"
        ansible_ssh_private_key_file = "~/.ssh/conduit"
        ansible_python_interpreter = "/opt/homebrew/bin/python3"
    }
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook main.yaml  -e 'env=dev' --ask-vault-pass"
    working_dir = "${path.module}/ansible"
  }

  depends_on = [
    ansible_host.conduit-tf
  ]
}

output "ip" {
    value = "${aws_instance.conduit-tf.public_ip}"
}