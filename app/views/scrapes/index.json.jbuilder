json.array!(@scrapes) do |scrape|
  json.extract! scrape, :id, :url, :title, :description, :page_type, :image, :locale, :site_name
  json.url scrape_url(scrape, format: :json)
end
