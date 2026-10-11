require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  describe 'POST /login' do
    context '正しい認証情報の場合' do
      let(:user) do
        User.create!(
          username: 'tester',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        )
      end
      it 'ログインに成功する' do
        post login_path, params: {
          email: user.email,
          password: 'password123'
        }

        expect(response).to redirect_to(root_path)

        get books_search_path
        expect(response).to have_http_status(:ok)
      end

      it 'ログインに失敗する' do
        post login_path, params: {
          email: user.email,
          password: 'passwordxxx'
        }
        
        expect(response).to have_http_status(:unprocessable_content)

        get books_search_path
        expect(response).to redirect_to(login_path) 
      end

      it 'ログアウトに成功する' do
        post login_path, params: {
          email: user.email,
          password: 'password123'
        }
        delete logout_path
        
        expect(response).to have_http_status(303)

        get root_path
        expect(response).to redirect_to(login_path) 
      end
    end
  end
end