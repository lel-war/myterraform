#installing openvpn through third-party openvpn script by dumrauf you can check it out here: https://github.com/dumrauf
resource "null_resource" "openvpn_install" {
  depends_on = [aws_instance.bastion, aws_eip_association.eip_assoc]
  connection {
    type        = "ssh"
    host        = "${var.eip_ip4}"
    user        = "ec2-user"
    port        = "22"
    private_key = file("~/.ssh/id_rsa")
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "curl -O https://raw.githubusercontent.com/dumrauf/openvpn-install/master/openvpn-install.sh",
      "chmod +x openvpn-install.sh",
      <<EOT
      sudo AUTO_INSTALL=y \
           APPROVE_IP=${var.eip_ip4} \
           ENDPOINT=${aws_instance.bastion.public_dns} \
           ./openvpn-install.sh
      
EOT
      ,
    ]
  }
}
#adding user to connect to vpn through third party script by dumrauf you can check it out here: https://github.com/dumrauf
resource "null_resource" "openvpn_adduser" {
  depends_on = [null_resource.openvpn_install]

  triggers = {
    ovpn_user = "${var.ovpn_user}"
  }

  connection {
    type        = "ssh"
    host        = "${var.eip_ip4}"
    user        = "ec2-user"
    port        = "22"
    private_key = file("~/.ssh/id_rsa")
    agent       = false
  }


  provisioner "remote-exec" {
    inline = [
      "curl -O https://raw.githubusercontent.com/dumrauf/openvpn-terraform-install/master/scripts/update_users.sh",  
      "chmod +x ~/update_users.sh",
      "sudo ~/update_users.sh ${var.ovpn_user}",
    ]
  }
}

#download ovpn configurations to use with openvpn client
resource "null_resource" "openvpn_download_configurations" {
  depends_on = [null_resource.openvpn_adduser]

  triggers = {
    ovpn_user = "${var.ovpn_user}"
  }

  provisioner "local-exec" {
    command = <<EOT
    mkdir -p ~/${var.ovpn_user}-config;
    scp -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -i ~/.ssh/id_rsa ec2-user@${var.eip_ip4}:/home/ec2-user/*.ovpn ~/${var.ovpn_user}-config/
    
EOT

  }
}