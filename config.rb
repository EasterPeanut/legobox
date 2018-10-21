# Global settings

config[:company_address] = "Gouwe 102"
config[:company_country] = "Nederland"
config[:company_email] = "info@legobox.io"
config[:company_lat] = "53.000986"
config[:company_long] = "6.538577"
config[:company_phone_number] = "+31 65 777 5633"
config[:company_placename] = "Assen"
config[:company_postal_code] = "9406 GS"
config[:company_name] = "Legobox"
config[:host] = "localhost"
config[:meta_csp_settings] = " img-src https://*; child-src 'none';"
config[:meta_geo_position] = config[:company_lat] + ";" + config[:company_long]
config[:meta_geo_placename] = config[:company_placename] + ", " + config[:company_country]
config[:meta_geo_region] = "NL-DR"
config[:root_locale] = :nl
config[:locales] = [:nl, :en]
config[:sm_fb_app_id] = "123456789"
config[:sm_twitter_site_account] = "@legobox"
config[:sm_twitter_user_account] = "@legoman"

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
activate :directory_indexes
activate :livereload
activate :i18n, mount_at_root: config[:root_locale], :langs => config[:locales]
# activate :search

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# With alternative layout
# page "/path/to/file.html", layout: "other_layout"

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   "/this-page-has-no-template.html",
#   "/template-file.html",
#   locals: {
#     which_fake_page: "Rendering a fake page with a local variable"
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  # Get full locale (eg. nl_NL)
  def full_locale(lang = I18n.locale)
    case lang
      when :en
        "en_US"
      else
        "#{lang.downcase}_#{lang.upcase}"
    end
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  config[:host] = "https://www.legobox.io"

  activate :minify_css
  activate :minify_html
  activate :minify_javascript

  # Append a hash to asset urls (make sure to use the url helpers)
  activate :asset_hash

  activate :asset_host, :host => "//legobox.io"
end
