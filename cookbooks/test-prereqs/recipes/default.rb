directory '/tmp/kitchen/.chef' do
  owner 'kitchen'
  group 'kitchen'
  mode '0755'
  action :create
end

cookbook_file "/tmp/kitchen/.chef/knife.rb" do
  source 'knife.rb'
  owner 'kitchen'
  group 'kitchen'
  mode '0777'
  action :create
end

cookbook_file "/tmp/kitchen/.chef/stickywicket.pem" do
  source 'stickywicket.pem'
  owner 'kitchen'
  group 'kitchen'
  mode '0777'
  action :create
end
