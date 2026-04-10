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

  def link_to_home(html_attributes = {})
    link_to(root_path, **html_attributes) do
      tag.i(class: "bi bi-house")
    end
  end

  def nav_link_attributes(path, classes: [], method: :get)
    classes = Array(classes)
    return { class: safe_join([ "nav-link" ] + classes, " ") } unless current_page?(path, method:)

    { class: safe_join(([ "nav-link", "active" ] + classes).compact, " "), aria_current: "page" }
  end

  def sign_in_link(html_attributes = {})
    return if authenticated?

    html_attributes[:class] ||= "ms-auto btn"

    link_to(root_path, **html_attributes) do
      tag.i(class: "bi bi-box-arrow-right") + tag.span("Sign In", class: "d-none d-md-inline ps-md-2")
    end
  end

  def sign_out_link(html_attributes = { form_class: "ms-auto", class: "btn" })
    return unless authenticated?

    button_to(session_path, method: :delete, **html_attributes) do
      tag.i(class: "bi bi-box-arrow-left") + tag.span("Sign Out", class: "d-none d-md-inline ps-md-2")
    end
  end
end
