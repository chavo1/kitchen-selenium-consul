public_dns_servers_sofia = attribute(
  "public_dns_servers_sofia",
  description: "server dns"
)

public_dns_servers_varna = attribute(
  "public_dns_servers_varna",
  description: "server dns"
)

# puts(public_dns_servers_sofia.length)
# puts(public_dns_servers_varna.length)

1.upto(public_dns_servers_sofia.length) do |x|
  
  describe http("http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/services") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/nodes") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/services/web") do
    its('status') { should cmp 200 }
  end
end

1.upto(public_dns_servers_varna.length) do |y|

  describe http("http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/services") do
  its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/nodes") do
    its('status') { should cmp 200 }
  end
  describe http("http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/services/web") do
    its('status') { should cmp 200 }
  end
end