require "test_helper"

class DnsResourcesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DnsResources::VERSION
  end

  def test_it_gets_valid_resources
    ipv4 = Resolv::DNS::Resource::IN::A.new("192.168.1.1")
    minfo = Resolv::DNS::Resource::MINFO.new("testrmailbx", "testemailbx")
    hinfo = Resolv::DNS::Resource::HINFO.new("Intel Core i7", "Linux")
    
    assert_equal DnsResources.get_resource_values(ipv4), { address: "192.168.1.1" }
    assert_equal DnsResources.get_resource_values(minfo), { emailbx: "testemailbx", rmailbx: "testrmailbx" }
    assert_equal DnsResources.get_resource_values(hinfo), { cpu: "Intel Core i7", os: "Linux" }
  end

  def test_it_does_not_try_to_get_invalid_resources
    assert_equal DnsResources.get_all_resources('newgnowegbeowg'), []
  end
end
