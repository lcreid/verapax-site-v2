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

  def link_to_home
    link_to(root_path) do
      tag.i(class: "bi bi-house")
    end
  end

  def sign_in_link
    return if Current.user.present?

    link_to(root_path, class: "ms-auto btn") do
      tag.i(class: "bi bi-box-arrow-right") + tag.span("Sign In", class: "d-none d-md-inline ps-md-2")
    end
  end

  def sign_out_link
    return unless Current.user.present?

    button_to(session_path, method: :delete, form_class: "ms-auto", class: "btn") do
      tag.i(class: "bi bi-box-arrow-left") + tag.span("Sign Out", class: "d-none d-md-inline ps-md-2")
    end
  end

  def top_menu
    tag.div(class: "d-flex") do
      safe_join([ link_to_home, sign_in_link, sign_out_link ].compact)
    end
  end
end
