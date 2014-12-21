require "itamae/resource/base"

module Itame
  module Plugin
    module Resource
      class Tar < Itame::Resource::Base
        define_attribute :action, default: :create
        defing_attribute :source, type: String, default_name: true
        defing_attribute :to, type: String
        define_attributes :option, type: String

        def action_create(options)
          to = ::File.dirname(attributes.source) if attributes.to.empty?
          result = run_command(["tar", attributes.option, attributes.source, "#{to}"])
          if result.exit_status != 0
            Logger.info "tar:"
            result.stdout.each_line do |line|
              Logger.info "#{line.strip}"
            end
          end
        end
      end
    end
  end
end
