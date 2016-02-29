#TODO: edit the below line to reflect the attribute name you want to check
$attribute_to_debug = "check_me"

require 'chef/dsl/include_attribute'

require 'chef/node/attribute'
class ::Chef
  class Node
    class Attribute
      class_eval do
        @methods_to_wrap = [
          :default=,
          :role_default=,
          #:env_default=,
          :force_default=,
          :normal=,
          :override=,
          :role_override=,
          #:env_override=,
          :force_override=,
          :automatic=,
          :default!,
          :force_default!,
          :normal!,
          :override!,
          :force_override!,
        ]

        #differnet versions of chef have different method names
        @method_backups = @methods_to_wrap.inject({}) do |acc, method_name|
          if method_defined?(method_name)
            acc[method_name] = instance_method(method_name)
          end
          acc
        end

        #wrap all the setter methods
        @method_backups.each do |method_name, method_backup|
          define_method method_name do |opts|
            opts = checkForAttributeToDebug(opts)
            method_backup.bind(self).call(opts)
          end
        end

        #if the key we are trying to debug exists in the opts, add the debug value
        def checkForAttributeToDebug(opts)
          if opts.include?($attribute_to_debug)
            if opts.include?(:attribute_debug_location)
              opts[:attribute_debug_location]=opts[:attribute_debug_location]
            else
              opts[:attribute_debug_location]=caller[1]
            end
          end

          return opts
        end

      end
    end
  end
end

require 'chef/run_list/run_list_expansion'
class ::Chef
  class RunList
    class RunListExpansion
      class_eval do
        @methods_to_wrap = [
          :apply_role_attributes
        ]

        #differnet versions of chef have different method names
        @method_backups = @methods_to_wrap.inject({}) do |acc, method_name|
          if method_defined?(method_name)
            acc[method_name] = instance_method(method_name)
          end
          acc
        end

        #wrap all the setter methods
        @method_backups.each do |method_name, method_backup|
          define_method method_name do |opts|
            opts = checkForAttributeToDebug(opts)
            method_backup.bind(self).call(opts)
          end
        end

        #if the key we are trying to debug exists in the opts, add the debug value
        def checkForAttributeToDebug(opts)
          if opts.default_attributes.include?($attribute_to_debug)
            opts.default_attributes[:attribute_debug_location]= opts.name + " default in role"
          end
          if opts.override_attributes.include?($attribute_to_debug)
            opts.override_attributes[:attribute_debug_location]= opts.name + " override in role"
          end
          return opts
        end

      end
    end
  end
end


require 'chef/environment'
class ::Chef
  class Environment
    class_eval do
      backup_default_attributes = instance_method(:default_attributes)
      define_method :default_attributes do |arg=nil|
        if !$attribute_to_debug.nil? && !arg.nil? && arg.include?($attribute_to_debug)
          arg['attribute_debug_location']="assigned from '#{@name}' environment - at default level"
        end
        backup_default_attributes.bind(self).call(arg)
      end

      backup_override_attributes = instance_method(:override_attributes)
      define_method :override_attributes do |arg=nil|
        if !$attribute_to_debug.nil? && !arg.nil? && arg.include?($attribute_to_debug)
          arg['attribute_debug_location']="assigned from '#{@name}' environment - at override level"
        end
        backup_override_attributes.bind(self).call(arg)
      end
 
    end
  end
end

require 'chef/node/attribute_collections'
class ::Chef
  class Node
    class VividMash

      assign_method = instance_method(:[]=)
      define_method :[]= do |key, value|

        if key == $attribute_to_debug
            #additionally store where it was set from
            assign_method.bind(self).call(:attribute_debug_location, caller[0])
        end

        assign_method.bind(self).call(key,value)
      end
    end
  end
end
