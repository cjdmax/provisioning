variable "count" {}

variable "public_ips" {
  type = "list"
}

variable "hostnames" { 
	type = "list"
}

variable "domain" {
  type = "string"
}

resource "null_resource" "sshfp" {

	count = "${var.count}"
	
	provisioner "local-exec" {
		command = "ssh-keygen -f \"$HOME/.ssh/known_hosts\" -R ${element(var.public_ips,count.index)}"
	}
	
	provisioner "local-exec" {
		command = "ssh-keyscan -H ${element(var.hostnames,count.index)}.${var.domain},${element(var.public_ips,count.index)} >> \"$HOME/.ssh/known_hosts\""
	}
}

