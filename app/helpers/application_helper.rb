# frozen_string_literal: true

module ApplicationHelper
  def hero(&)
    tag.div(class: "hero mb-5") do
      tag.div(class: "d-flex align-items-center h-100") do
        tag.div(class: "hero-image h-100 w-100 d-flex align-items-end") do
          tag.div(class: "hero-content pb-5") do
            capture(&) if block_given?
          end
        end
      end
    end
  end
end
