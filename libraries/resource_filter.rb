require 'chef/resource'

class Chef
  class Resource
    # Logstash Filter Configuration File Resource
    class LogstashFilter < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :logstash_filter
        @provider = Chef::Provider::LogstashConfig
        @action = :create
        @allowed_actions = [:create, :delete]
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
          :default => "filter.#{name}.conf.erb"
        )
      end

      def variables(arg = nil)
        set_or_return(
          :variables, arg,
          :kind_of => Hash,
          :default => {}
        )
      end
    end
  end
end
