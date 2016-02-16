class Scrape < ActiveRecord::Base
  validates :url, :uniqueness => { :message => " - A cached scrape exists for that URL." }

  def to_param
    url.gsub("www.","")
  end
end
