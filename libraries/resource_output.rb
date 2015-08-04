require 'chef/resource'

class Chef
  class Resource
    # Logstash Input Configuration File Resource
    class LogstashOutput < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :logstash_output
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
          :default => "output.#{name}.conf.erb"
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
          :default => 'root'
        )
      end

      def group(arg = nil)
        set_or_return(
          :group, arg,
          :kind_of => String,
          :default => 'root'
        )
      end
    end
  end
end
