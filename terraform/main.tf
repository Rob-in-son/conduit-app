resource "aws_instance" "conduit-tf" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.conduit-app-sg.id]
    # user_data = templatefile(var.userdata_script, {})

    tags = {
        Name = "conduit-tf"
    }

    # Add the ip address to the ansible hosts file
    # provisioner "local-exec" {
    #     command = "echo ${self.public_ip} >> /etc/ansible/hosts"
    # }
}

resource "ansible_host" "conduit-tf" {
    # ansible host details
    name = aws_instance.conduit-tf.public_dns
    groups = ["ansible_client"]
    variables = {
    ansible_user = "ubuntu"
    ansible_ssh_private_key_file = "~/.ssh/id_rsa"
    ansible_python_interpreter = "/opt/homebrew/bin/python3"
    }
}

output "ip" {
    value = "${aws_instance.conduit-tf.public_ip}"
}