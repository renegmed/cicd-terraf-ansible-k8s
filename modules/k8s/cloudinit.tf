data "template_file" "k8s-init" {
  template = file("modules/k8s/scripts/kubernetes-init.sh")
  vars = {
    DEVICE            = var.instance_device_name  
  }
}

data "template_cloudinit_config" "cloudinit-k8s" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.k8s-init.rendered
  }
}