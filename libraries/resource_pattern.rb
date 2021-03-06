require 'chef/resource'

class Chef
  class Resource
    # Logstash Filter Configuration File Resource
    class LogstashPattern < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :logstash_pattern
        @provider = Chef::Provider::LogstashConfig
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :required => true,
          :default => nil
        )
      end

      def source(arg = nil)
        set_or_return(
          :source, arg,
          :kind_of => String,
          :default => "pattern.#{name}.erb"
        )
      end

      def variables(arg = nil)
        set_or_return(
          :variables, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def owner(arg = nil)
        set_or_return(
          :owner, arg,
          :kind_of => String,
          :default => node['logstash']['user']
        )
      end

      def group(arg = nil)
        set_or_return(
          :pattern, arg,
          :kind_of => String,
          :default => node['logstash']['group']
        )
      end
    end
  end
end
