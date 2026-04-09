# frozen_string_literal: true

module HomeHelper
  def partner_link(href:, src:, alt:, &)
    link_to(href:, class: "d-block text-center my-auto") do
      image = image_tag(src, class: "img-fluid client-logo d-block m-auto px-5", alt:) if src.present?
      safe_join([ image, capture(&) ].compact)
    end
  end
end
