# frozen_string_literal: true

# Put this file in `lib` because that path is in the LOAD_PATH during initialization.
# The usual Rails locations aren't yet in the LOAD_PATH.

# app/template_handlers/markdown_handler.rb
class MarkdownHandler
  class << self
    def call(template, source = nil)
      source ||= template.source

      <<~RUBY
        renderer = Redcarpet::Render::HTML.new(
          filter_html: true,
          hard_wrap: true
        )

        markdown = Redcarpet::Markdown.new(
          renderer,
          autolink: true,
          tables: true,
          fenced_code_blocks: true
        )

        markdown.render(#{source.inspect}).html_safe
      RUBY
    end
  end
end
