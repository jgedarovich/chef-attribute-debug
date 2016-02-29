require 'serverspec'

describe "A force_default attribute located in a cookbook attribute file" do

  #all things run as root, starting from /home/kitchen, reset in each describe..
  describe command('/opt/chef/embedded/bin/chef-zero &') do
     its(:exit_status) { should eq 0 }
  end
 
  describe command('cd /tmp/kitchen && knife upload .') do
     its(:exit_status) { should eq 0 }
     its(:stderr) { should eq '' }
  end

  describe command ('cd /tmp/kitchen && knife node show 5-force-default-in-attribute-file-ubuntu-1204 -a attribute_debug_location') do
     its(:exit_status) { should eq 0 }
     its(:stdout) { should eq "5-force-default-in-attribute-file-ubuntu-1204:\n  attribute_debug_location: /tmp/kitchen/cache/cookbooks/5-force-default-in-attribute-file/attributes/default.rb:1:in `from_file'\n" }
     its(:stderr) { should eq '' }
  end
end

