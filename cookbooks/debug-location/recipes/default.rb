puts ""
puts ""
puts ""
puts "---------------------------"
puts "FINAL RESULTS:"
puts "---------------------------"
puts "key: "+ node[:attribute_to_debug]
puts "value: "+ node[node[:attribute_to_debug]]
puts "from: "+node[:attribute_debug_location]
if node.attribute?(:environment)
  puts "environment: "+node[:environment]
end
puts ""
puts ""
puts ""
