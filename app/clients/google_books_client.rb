class GoogleBooksClient
  BASE_URL = "https://www.googleapis.com/books/v1"

  def self.search(query)
    conn = Faraday.new(BASE_URL) do |f|
      f.response :raise_error
      f.options.open_timeout = 5
      f.options.read_timeout = 10
    end
    response = conn.get("volumes") do |req|
      req.params["q"] = query
      req.params["key"] = ENV["GOOGLE_BOOKS_API_KEY"]
    end
    response_body = response.body
    data = JSON.parse(response_body)
  end
end
