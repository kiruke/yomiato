class BooksController < ApplicationController

  def create
    @book = Book.new(google_books_params)
    if @book.save
      redirect_to books_search_path, notice: '保存しました'
    else
      flash.now[:danger] = '保存に失敗ししました'
      render :search, status: :unprocessable_entity
    end
  end

  def search
    query = params[:query]

    return if query.blank?

    begin
      data = GoogleBooksClient.search(query)
    rescue URI::OpenURI::HTTPError
      @error_message = "通信に失敗しました"
      return
    end

    @book_data = (data["items"] || []).map do |book|
      {
        title: book["volumeInfo"]["title"],
        author: book["volumeInfo"]["authors"]&.first,
        image_link: book.dig("volumeInfo", "imageLinks", "thumbnail"),
        info_link: book["volumeInfo"]["infoLink"],
        published_at: book["volumeInfo"]["publishedDate"],
        bookid: book["volumeInfo"]["id"]
      }
    end
  end

  private
  
  def google_books_params
    params.require(:book).permit(:title, :author, :info_link, :image_link, :published_at)
  end
end
