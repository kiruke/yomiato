require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "GET /reviews/new" do
    let(:user) do
      User.create!(
        username: 'tester',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it "未ログインの場合、ログイン画面にリダイレクトされること" do
      get "/reviews/new"

      expect(response).to redirect_to(login_path)
    end

    it "ログイン済みユーザーはレビュー作成画面を表示できること" do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }
      get "/reviews/new"

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /reviews" do
    let(:user) do
      User.create!(
        username: 'tester',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    let(:book) do
      Book.create!(
        title: 'テスト',
        author: 'test',
        isbn: '1234567890123',
        published_at: '2022-02-02'
      )
    end

    it "ログイン済みユーザーが妄想レビューを保存できること" do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }

      expect {
        post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: 'これは妄想レビューです。'
          }
        }
      }.to change(Review, :count).by(1)

      review = Review.last
      expect(review.user).to eq(user)
      expect(review.book).to eq(book)
    end

    it "未ログインユーザーはレビューを保存できないこと" do
      expect {
        post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: 'これは妄想レビューです。'
          }
        }
      }.not_to change(Review, :count)

      expect(response).to redirect_to(login_path)
    end

    it "レビュー本文が空の場合、保存できないこと" do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }

      expect {
        post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: ''
          }
        }
      }.not_to change(Review, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "同じユーザが同じ書籍に対して複数のレビューを投稿できないこと" do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }

      expect{ post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: 'これは妄想レビューです。'
          }
        }
      }.to change(Review, :count).by(1)

      expect {
        post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: 'これは妄想レビューです。'
          }
        }
      }.not_to change(Review, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end

    it "レビュー本文が800文字を超える場合、保存できないこと" do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }

      expect {
        post reviews_path, params: {
          book_id: book.id,
          review: {
            pre_review: 'a' * 801
          }
        }
      }.not_to change(Review, :count)

      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
