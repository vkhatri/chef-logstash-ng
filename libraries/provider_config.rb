require 'chef/provider/template'
require 'chef/resource/template'

class Chef
  class Provider
    # Logstash Config Files Provider
    class LogstashConfig < Chef::Provider
      def initialize(*args)
        super
      end

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_create
        new_resource.updated_by_last_action(resource_file(:create))
      end

      def action_remove
        new_resource.updated_by_last_action(resource_file(:delete))
      end

      private

      def resource_file_path
        case new_resource.resource_name
        when :logstash_input
          ::File.join(node['logstash']['conf_dir'], "10_input_#{new_resource.name}.conf")
        when :logstash_filter
          ::File.join(node['logstash']['conf_dir'], "20_filter_#{new_resource.name}.conf")
        when :logstash_output
          ::File.join(node['logstash']['conf_dir'], "90_output_#{new_resource.name}.conf")
        when :logstash_pattern
          ::File.join(node['logstash']['patterns_dir'], new_resource.name)
        else
          fail ">> unknown resource name #{new_resource.resource_name.inspect} for provider config"
        end
      end

      def resource_file(run_action)
        t = Chef::Resource::Template.new(resource_file_path, run_context)
        t.cookbook new_resource.cookbook
        t.source new_resource.source
        t.owner new_resource.owner
        t.group new_resource.group
        t.variables new_resource.variables
        t.notifies :restart, 'service[logstash]', :delayed
        t.run_action run_action
        t.updated_by_last_action?
      end
    end
  end
end
