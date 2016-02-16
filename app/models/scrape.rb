class Scrape < ActiveRecord::Base
  validates :url, uniqueness: true

  def to_param
    url.gsub("www.","")
  end
end
