# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

ActionView::TemplateRenderer.class_eval do
  def render_template_with_tracking(template, layout_name = nil, locals = {})
    @view.instance_variable_set(:@_rendered_template, template.inspect.gsub(/(\..*)/, '').split('/')[-2..-1].join('-'))
    out = render_template_without_tracking(template, layout_name, locals)
    @view.instance_variable_set(:@_rendered_template, nil)
    return out
  end
end
