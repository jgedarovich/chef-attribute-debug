require 'serverspec'

describe "A default attribute located in role" do

  #all things run as root, starting from /home/kitchen, reset in each describe..
  describe command('/opt/chef/bin/chef-zero &') do
     its(:exit_status) { should eq 0 }
  end
 
  describe command('cd /tmp/kitchen && knife upload .') do
     its(:exit_status) { should eq 0 }
     its(:stderr) { should eq '' }
  end

  describe command ('cd /tmp/kitchen && knife node show 4-default-in-role-ubuntu-1204 -a attribute_debug_location') do
     its(:exit_status) { should eq 0 }
     its(:stdout) { should eq "4-default-in-role-ubuntu-1204:\n  attribute_debug_location: 4-default-in-role\n"}
     its(:stderr) { should eq '' }
  end
end

