#!/usr/bin/env ruby

public_dns_servers_sofia = attribute(
  "public_dns_servers_sofia",
  description: "server dns"
)

public_dns_servers_varna = attribute(
  "public_dns_servers_varna",
  description: "server dns"
)
 
require 'rubygems'
require 'selenium-webdriver'

0.upto(1) do |n|

  browser = Selenium::WebDriver.for :firefox

  browser.get "http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/services"
  sleep 2
  browser.save_screenshot("consul_services_sofia-#{00+n}.png")

  browser.get "http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/services/web"
  sleep 2
  browser.save_screenshot("consul_services_sofia_web-#{00+n}.png")

  browser.get "http://#{public_dns_servers_sofia[n]}:8500/ui/sofia/nodes"
  sleep 2
  browser.save_screenshot("consul_nodes_sofia-#{00+n}.png")

  browser.get "http://#{public_dns_servers_varna[n]}:8500/ui/varna/services"
  sleep 2
  browser.save_screenshot("consul_services_varna-#{00+n}.png")

  browser.get "http://#{public_dns_servers_varna[n]}:8500/ui/varna/services/web"
  sleep 2
  browser.save_screenshot("consul_services_varna_web-#{00+n}.png")

  browser.get "http://#{public_dns_servers_varna[n]}:8500/ui/varna/nodes"
  sleep 2
  browser.save_screenshot("consul_nodes_varna-#{00+n}.png")

  browser.quit
end

