require 'coderay'
require 'redcarpet'
require 'action_controller'

require 'documentation/html_with_coderay'

ActionView::Template.register_template_handler :md,
  lambda { |template| "Redcarpet::Markdown.new(HTMLWithCoderay, {:autolink => true, :space_after_headers => true, :fenced_code_blocks => true }).render(#{template.source.inspect})" }

module Documentation
  module Rails
    module Handlers
      class Markdoc
        def default_format
          ::Mime::HTML
        end

        def self.erb_handler
          @@erb_handler ||= ::ActionView::Template.registered_template_handler(:erb)
        end

        def self.markdown_handler
          @@markdown_handler ||= ::ActionView::Template.registered_template_handler(:md)
        end

        def self.call(template)
          compiled_source = erb_handler.call(template)
          if template.formats.include?(:html)
            markdown_handler.call(compiled_source)
          else
            compiled_source
          end
        end
      end
    end
  end
end

ActionView::Template.register_template_handler(:markdoc, Documentation::Rails::Handlers::Markdoc.new)

class ActionController::Responder
  def to_documentation
    controller.render :md => controller.action_name
  end
end

Mime::Type.register_alias "text/html", :documentation

ActionController::Renderers.add :documentation do |md, options|
  self.content_type = Mime::HTML
  html = Redcarpet::Markdown.new(HTMLWithCoderay,
                                 {:autolink => true,
                                  :space_after_headers => true,
                                  :fenced_code_blocks => true }).render(md)
  self.response_body = html
end

require 'documentation/rails/version'
require 'documentation/rails/engine'
