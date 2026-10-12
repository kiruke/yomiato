require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    context '有効な入力の場合' do
      it 'ユーザー登録に成功する' do
        expect {
          post users_path, params: {
            user: {
              username: 'tester',
              email: 'test@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        }.to change(User, :count).by(1)

        expect(User.last.email).to eq 'test@example.com'
        expect(response).to redirect_to(root_path)
        get books_search_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'パスワード確認が一致しない場合' do
      it 'ユーザー登録に失敗する' do
        expect {
          post users_path, params: {
            user: {
              username: 'tester',
              email: 'test@example.com',
              password: 'password123',
              password_confirmation: 'passwordxxx'
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end