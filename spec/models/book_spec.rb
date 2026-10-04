require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'Book can be created with valid attributes' do
    book = Book.new(
      title: 'テスト',
      author: 'test',
      isbn: '1234567890123',
      published_at: '2022-02-02'
    )

    expect(book).to be_valid
  end

  it 'Book is invalid when title is blank' do
    book = Book.new
    expect(book).not_to be_valid
  end

  it 'Book is invalid when ISBN is not 13 characters' do
    book = Book.new(
      title: 'テスト',
      author: 'test',
      isbn: '12345678901231111111111111',
      published_at: '2022-02-02'
    )

    expect(book).not_to be_valid
  end
end