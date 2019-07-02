#!/usr/bin/env ruby

public_dns_servers_sofia = attribute(
  "public_dns_servers_sofia",
  description: "server dns"
)

public_dns_servers_varna = attribute(
  "public_dns_servers_varna",
  description: "server dns"
)

puts(public_dns_servers_sofia.length)
puts(public_dns_servers_varna.length)

require 'rubygems'
require 'selenium-webdriver'

1.upto(public_dns_servers_sofia.length) do |x|

  browser = Selenium::WebDriver.for :firefox

  browser.get "http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/services"
  sleep 2
  browser.save_screenshot("consul_services_sofia-#{00+x}.png")

  browser.get "http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/services/web"
  sleep 2
  browser.save_screenshot("consul_services_sofia_web-#{00+x}.png")

  browser.get "http://#{public_dns_servers_sofia[x -1]}:8500/ui/sofia/nodes"
  sleep 2
  browser.save_screenshot("consul_nodes_sofia-#{00+x}.png")

  browser.quit
end

1.upto(public_dns_servers_varna.length) do |y|

  browser = Selenium::WebDriver.for :firefox

  browser.get "http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/services"
  sleep 2
  browser.save_screenshot("consul_services_varna-#{00+y}.png")

  browser.get "http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/services/web"
  sleep 2
  browser.save_screenshot("consul_services_varna_web-#{00+y}.png")

  browser.get "http://#{public_dns_servers_varna[y -1]}:8500/ui/varna/nodes"
  sleep 2
  browser.save_screenshot("consul_nodes_varna-#{00+y}.png")

  browser.quit
end

