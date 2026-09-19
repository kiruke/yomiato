require "open-uri"

class BooksController < ApplicationController
  def search
    query = params[:query]

    return if query.blank?

    query = URI.encode_www_form_component(query)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{query}"
    url_with_key = "#{url}&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    begin
      response = URI.open(url_with_key)
    rescue URI::OpenURI::HTTPError
      @error_message = "通信に失敗しました"
      return
    end
    body = response.read
    data = JSON.parse(body)
    @book_data = (data["items"] || []).map do |book|
      {
        title: book["volumeInfo"]["title"],
        author: book["volumeInfo"]["authors"]&.first,
        image_link: book.dig("volumeInfo", "imageLinks", "thumbnail"),
        info_link: book["volumeInfo"]["infoLink"],
        published_at: book["volumeInfo"]["publishedDate"]
      }
    end
  end
end
