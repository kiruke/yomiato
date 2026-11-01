class BooksController < ApplicationController
  def create
    @book = Book.find_or_create_by(isbn: google_books_params[:isbn]) do |book|
      book.assign_attributes(google_books_params)
    end
    if @book.persisted?
      redirect_to new_review_path(book_id: @book.id)
    else
      flash.now[:danger] = 'もう一度選択してください'
      render :search, status: :unprocessable_content
    end
  end

  def search
    query = params[:query]

    return if query.blank?

    begin
      data = GoogleBooksClient.search(query)
    rescue Faraday::Error
      @error_message = '通信に失敗しました'
      return
    end

    @book_data = (data['items'] || []).map do |book|
      identifiers = book['volumeInfo']['industryIdentifiers'] || []
      isbn_data = identifiers.find do |item|
        item['type'] == 'ISBN_13'
      end
      isbn = isbn_data&.[]('identifier')
      {
        title: book['volumeInfo']['title'],
        author: book['volumeInfo']['authors']&.first,
        image_link: book.dig('volumeInfo', 'imageLinks', 'thumbnail'),
        info_link: book['volumeInfo']['infoLink'],
        published_at: book['volumeInfo']['publishedDate'],
        bookid: book['id'],
        isbn: isbn
      }
    end
  end

  private

  def google_books_params
    params.expect(
      book: %i[title author info_link image_link published_at isbn]
    )
  end
end
