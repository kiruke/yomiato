require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "Book can be created with valid attributes" do
    book = Book.new(
      title: "テスト",
      author: "test",
      isbn: "1234567890123",
      published_at: "2022-02-02"
    )

    assert book.valid?
  end

  test "Book is invalid when title is blank" do
    book = Book.new()

    assert_not book.valid?
  end
  
  test "Book is invalid when ISBN is not 13 characters" do
    book = Book.new(
      title: "テスト",
      author: "test",
      isbn: "12345678901231111111111111",
      published_at: "2022-02-02"
    )

    assert_not book.valid?
  end
end
