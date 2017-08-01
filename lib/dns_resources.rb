require "dns_resources/version"
require "resolv"

module DnsResources
  RESOURCE = Resolv::DNS::Resource
  IN = RESOURCE::IN

  RESOURCE_TYPES = [
    {resource: IN::A, type: "IPv4"},
    {resource: IN::AAAA, type: "IPv6"},
    {resource: IN::CNAME, type: "cname"},
    {resource: RESOURCE::HINFO, type: "hinfo"},
    {resource: RESOURCE::MINFO, type: "minfo"},
    {resource: RESOURCE::MX, type: "mx"},
    {resource: IN::NS, type: "ns"},
    {resource: RESOURCE::PTR, type: "ptr"},
    {resource: RESOURCE::SOA, type: "soa"},
    {resource: IN::SRV, type: "srv"},
    {resource: RESOURCE::TXT, type: "txt"},
    {resource: IN::WKS, type: "wks"}
  ]

  def self.get_all_resources(host)
    result = []
    resources = Resolv::DNS.new.getresources(host, IN::ANY)
    unless resources.empty?
      resources.each do |resource|
        result << get_resource_by_type(host, resource.class)
      end
    end
    result
  end

  def self.get_resource_by_type(host, type)
    resource_type = type.class.eql?(String) ? get_type_class(type) : type
    resource = Resolv::DNS.new.getresource(host, resource_type)
    values = get_resource_values(resource)
    { type: get_type(resource.class) }.merge(values)
  end

  def self.get_resource_values(resource)
    return {} unless RESOURCE_TYPES.map { |v| v[:resource] }.include?(resource.class)
    case
    when resource.class.eql?(IN::A)
      { address: resource.address.to_s }
    when resource.class.eql?(IN::AAAA)
      { address: resource.address.to_s }
    when resource.class.eql?(IN::CNAME)
      { name: resource.name.to_s }
    when resource.class.eql?(RESOURCE::HINFO)
      { cpu: resource.cpu, os: resource.os }
    when resource.class.eql?(RESOURCE::MINFO)
      { emailbx: resource.emailbx, rmailbx: resource.rmailbx }
    when resource.class.eql?(RESOURCE::MX)
      { exchange: resource.exchange.to_s, preference: resource.preference }
    when resource.class.eql?(IN::NS)
      { name: resource.name.to_s }
    when resource.class.eql?(RESOURCE::PTR)
      { name: resource.name.to_s }
    when resource.class.eql?(RESOURCE::SOA)
      { mname: resource.mname.to_s, rname: resource.rname.to_s,
        refresh: resource.refresh, retry: resource.retry,
        expire: resource.expire, minimum: resource.minimum,
        serial: resource.serial }
    when resource.class.eql?(IN::SRV)
      { port: resource.port, priority: resource.priority,
        target: resource.target, weight: resource.weight }
    when resource.class.eql?(RESOURCE::TXT)
      { name: resource.strings }
    when resource.class.eql?(IN::WKS)
      { address: resource.address.to_s, bitmap: resource.bitmap, protocol: resource.protocol }
    else
      {}
    end
  end

  def self.get_type(resource_class)
    RESOURCE_TYPES.each do |v|
      return v[:type] if v[:resource].eql?(resource_class)
    end
  end

  def self.get_type_class(type)
    RESOURCE_TYPES.each do |v|
      return v[:resource] if v[:type].eql?(type)
    end
  end
end
