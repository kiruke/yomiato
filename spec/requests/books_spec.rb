require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books/search' do
    let(:user) do
      User.create!(
        username: 'tester',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'ログイン状態で書籍検索画面にアクセスできること' do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }

      get books_search_path

      expect(response).to have_http_status(:success)
    end

    it '未ログイン状態では書籍検索画面にアクセスできないこと' do
      get books_search_path

      expect(response).to redirect_to(login_path)
    end
  end
end