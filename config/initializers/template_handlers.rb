# frozen_string_literal: true

require "markdown_handler"

# Registers files ending in .md to use the MarkdownHandler
ActionView::Template.register_template_handler(:md, MarkdownHandler)
