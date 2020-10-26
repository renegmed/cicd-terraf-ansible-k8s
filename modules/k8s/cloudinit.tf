data "template_file" "k8s-init" {
  template = file("modules/k8s/scripts/kubernetes-init.sh")
  vars = {
    DEVICE                = var.instance_device_name 
    ROUTE53_NAME          = var.route_name
    KOPS_STATE_BUCKET     = "" # aws_s3_bucket.kops_state_bucket.id
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