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
  describe command('terraform state list') do
    its('stdout') { should include "module.consul_sofia.aws_instance.server[#{x -1}]" }
    its('stderr') { should include '' }
    its('exit_status') { should eq 0 }
  end
end

1.upto(public_dns_servers_varna.length) do |y|
  describe command('terraform state list') do
    its('stdout') { should include "module.consul_varna.aws_instance.server[#{y -1}]" }
    its('stderr') { should include '' }
    its('exit_status') { should eq 0 }
  end
end
