require 'serverspec'

describe "A default attribute located in an environment" do

  #all things run as root, starting from /home/kitchen, reset in each describe..
  describe command('/opt/chef/bin/chef-zero &') do
     its(:exit_status) { should eq 0 }
  end
 
  describe command('cd /tmp/kitchen && knife upload .') do
     its(:exit_status) { should eq 0 }
     its(:stderr) { should eq '' }
  end

  describe command ('cd /tmp/kitchen && knife node show 3-environment-default-ubuntu-1204 -a attribute_debug_location') do
     its(:exit_status) { should eq 0 }
     its(:stdout) { should eq "3-environment-default-ubuntu-1204:\n  attribute_debug_location: assigned from 'default' environment - at default level\n" }
     its(:stderr) { should eq '' }
  end
end

