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

  def search_form(url:, scope:, class: nil, &)
    form_with(url:, scope:, method: :get, class:, data: { controller: "auto-submit-search", turbo_action: "replace" }) do |form|
      capture(form, &)
    end
  end

  # By default, the helper is included in all controllers. If we call this `search_field`, it overrides
  # the Rails `search_field`. That might be something one could leverage if we didn't include helpers globally.
  def search_field_for_form(form:, class: "input-group", search: nil)
    tag.div(class:) do
      form.search_field(
        :search,
        value: search,
        data: { action: "auto-submit-search#submit" },
        class: "form-control form-control-sm",
        turbo_permanent: "",
        ) +
      tag.button(type="submit", class: "btn btn-sm btn-secondary") do
        tag.i(class: "bi bi-search")
      end
    end
  end
end
