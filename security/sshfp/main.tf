variable "count" {}

variable "items" {
  type = "list"
}

variable "domain" {
  type = "string"
}

resource "null_resource" "sshfp" {

	count = "${var.count}"
	
	provisioner "local-exec" {
		command = "ssh-keygen -f \"$HOME/.ssh/known_hosts\" -R ${element(var.items,count.index)}"
	}
	
	provisioner "local-exec" {
		command = "ssh-keyscan -H ${element(var.items,count.index)}} >> \"$HOME/.ssh/known_hosts\""
	}
}

