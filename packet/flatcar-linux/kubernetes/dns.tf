module "dns-entries" {
  source = "./dns/manual/"

  entries = [
    # etcd
    {
      # TODO: how to expand for multiple etcd entries?
      name    = format("%s-etcd%d.%s.", var.cluster_name, 0, var.dns_zone),
      type    = "A",
      ttl     = 300,
      records = [packet_device.controllers[0].access_private_ipv4],
    },
    # apiserver public
    {
      name    = format("%s.%s.", var.cluster_name, var.dns_zone),
      type    = "A",
      ttl     = 300,
      records = packet_device.controllers.*.access_public_ipv4,
    },
    # apiserver private
    {
      name    = format("%s-private.%s.", var.cluster_name, var.dns_zone),
      type    = "A",
      ttl     = 300,
      records = packet_device.controllers.*.access_private_ipv4,
    },
  ]
}