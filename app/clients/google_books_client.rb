require "uri"
require "open-uri"
class GoogleBooksClient

  def self.search(query)
    encoded_query = URI.encode_www_form_component(query)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{encoded_query}"
    url_with_key = "#{url}&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    response = URI.open(url_with_key)
    body = response.read
    data = JSON.parse(body)
  end
end