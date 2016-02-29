require 'serverspec'

describe "An override attribute located in a cookbook attribute file" do

  #all things run as root, starting from /home/kitchen, reset in each describe..
  describe command('/opt/chef/bin/chef-zero &') do
     its(:exit_status) { should eq 0 }
  end
 
  describe command('cd /tmp/kitchen && knife upload .') do
     its(:exit_status) { should eq 0 }
     its(:stderr) { should eq '' }
  end

  describe command ('cd /tmp/kitchen && knife node show 9-override-in-attribute-file-ubuntu-1204 -a attribute_debug_location') do
     its(:exit_status) { should eq 0 }
     its(:stdout) { should eq "9-override-in-attribute-file-ubuntu-1204:\n  attribute_debug_location: /tmp/kitchen/cache/cookbooks/9-override-in-attribute-file/attributes/default.rb:1:in `from_file'\n" }
     its(:stderr) { should eq '' }
  end
end

