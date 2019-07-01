module "consul_sofia" {
  source = "../"

  consul_version        = "${var.ami_virginia[var.consul_version]}"
  access_key            = "${var.access_key}"
  secret_key            = "${var.secret_key}"
  region                = "${var.region["virginia"]}"
  instance_type         = "${var.instance_type}"
  key_name              = "${var.key_name}"
  subnet                = "${var.subnet[0]}"
  server_count          = "${var.server_count}"
  dc_net                = "${var.dc_net["dc1"]}"
  dcname                = "${var.dcname["dc1"]}"
  vpc_security_group_id = "${var.vpc_security_group_id[0]}"
}

module "consul_varna" {
  source = "../"

  consul_version        = "${var.ami_ohio[var.consul_version]}"
  access_key            = "${var.access_key}"
  secret_key            = "${var.secret_key}"
  region                = "${var.region["ohio"]}"
  instance_type         = "${var.instance_type}"
  key_name              = "${var.key_name}"
  subnet                = "${var.subnet[1]}"
  server_count          = "${var.server_count}"
  dc_net                = "${var.dc_net["dc2"]}"
  dcname                = "${var.dcname["dc2"]}"
  vpc_security_group_id = "${var.vpc_security_group_id[1]}"
}

output "public_dns_servers_sofia" {
  value = "${module.consul_sofia.public_dns_servers}"
}

output "public_dns_servers_varna" {
  value = "${module.consul_varna.public_dns_servers}"
}
