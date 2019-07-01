public_dns_servers_sofia = attribute(
  "public_dns_servers_sofia",
  description: "server dns"
)

public_dns_servers_varna = attribute(
  "public_dns_servers_varna",
  description: "server dns"
)

0.upto(1) do |n|
  describe http("http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/services") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/nodes") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/services/web") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_varna[n]}:8500/ui/varna/services") do
  its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_varna[n]}:8500/ui/varna/nodes") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_varna[n]}:8500/ui/varna/services/web") do
    its('status') { should cmp 200 }
  end
end