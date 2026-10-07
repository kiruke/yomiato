require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) do
    User.new(
      username: 'テスト',
      email: 'test@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:book) do
    Book.new(
      title: 'テスト',
      author: 'test',
      isbn: '1234567890123',
      published_at: '2022-02-02'
    )
  end

  it 'is valid with valid attributes' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: 'test',
      post_review: ''
    )

    expect(review).to be_valid
  end

  it 'is invalid without pre_review' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: '',
      post_review: 'test'
    )

    expect(review).not_to be_valid
  end

  it 'is valid when pre_review is 800 characters long' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: 'a' * 800,
      post_review: ''
    )

    expect(review).to be_valid
  end

  it 'is invalid when pre_review exceeds 800 characters' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: 'a' * 801,
      post_review: ''
    )

    expect(review).not_to be_valid
  end

  it 'is valid when post_review is 1600 characters long' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: 'test',
      post_review: 'a' * 1600
    )

    expect(review).to be_valid
  end

  it 'is invalid when post_review exceeds 1600 characters' do
    review = Review.new(
      user: user,
      book: book,
      pre_review: 'test',
      post_review: 'a' * 1601
    )

    expect(review).not_to be_valid
  end

  it 'is invalid when the same user reviews the same book twice' do
    Review.create!(
      user: user,
      book: book,
      pre_review: 'test',
      post_review: ''
    )

    review = Review.new(
      user: user,
      book: book,
      pre_review: 'test',
      post_review: ''
    )

    expect(review).not_to be_valid
  end
end
