# Middleman - Inline SVG Helper
# ------------------------------------------------------------------------------
#
# Embed SVG files into your template files like so:
#
# ```
# <%= inline_svg "name/of/file.svg", class: "foo", data: {bar: "baz"} %>
# ```
#
# Output:
# ```
# <svg <!-- existing attributes --> class="foo" data-bar="baz">
#   <!-- SVG contents -->
# </svg>
# ```
module ImageHelpers
  def inline_svg(relative_image_path, optional_attributes = {})
    asset = sprockets.find_asset(relative_image_path)
    image_path = asset.try(:pathname) || asset.try(:filename)

    if File.exist?(image_path)
      embed_svg(image_path, optional_attributes)
    else
      embed_svg_with_error(relative_image_path)
    end
  end

  def embed_svg(image_path, optional_attributes)
    image = File.open(image_path, &:read)
    return image if optional_attributes.empty?

    document = Oga.parse_xml(image)
    svg      = document.css("svg").first
    add_attributes(svg, optional_attributes)

    document.to_xml
  end

  def add_attributes(svg, optional_attributes)
    optional_attributes.each do |attribute, value|
      if value == Hash
        svg_set_hash_attributes(value)
      else
        svg.set(attribute.to_sym, value.html_safe)
      end
    end
  end

  def svg_set_hash_attributes(value)
    value.each do |subattribute, subvalue|
      next unless subvalue.class == Hash

      svg.set("#{attribute} #{subattribute}".parameterize,
              subvalue.html_safe)
    end
  end

  def embed_svg_with_error(relative_image_path)
    %(
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 30"
        width="400px" height="30px">
        <text font-size="16" x="8" y="20" fill="#cc0000">
          Error: '#{relative_image_path}' could not be found.
        </text>
        <rect x="1" y="1" width="398" height="28" fill="none"
          stroke-width="1" stroke="#cc0000"/>
      </svg>
    )
  end

  private :embed_svg, :add_attributes, :svg_set_hash_attributes,
          :embed_svg_with_error
end
