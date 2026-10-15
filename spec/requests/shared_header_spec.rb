require 'rails_helper'

RSpec.describe 'SharedHeader', type: :request do
  describe 'GET /login' do
    it '未ログイン時にログインリンクと新規登録リンクを表示する' do
      get login_path

      document = Nokogiri::HTML(response.body)
      header = document.at_css('header')

      # ここにexpectを書く
      expect(header.text).to include('ログイン')
      expect(header.text).to include('新規登録')
      expect(header.text).not_to include('ログアウト')
    end
  end

  describe 'ログイン時のヘッダー' do
    let(:user) do
      User.create!(
        username: 'tester',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'ユーザー名とログアウトを表示する' do
      post login_path, params: {
        email: user.email,
        password: 'password123'
      }
      # ③ ログイン後のページにGETリクエストする
      get root_path

      # ④ ヘッダーのHTMLを取得する
      document = Nokogiri::HTML(response.body)
      header = document.at_css('header')

      # ⑤ 表示内容を検証する
      expect(header.text).to include('ログアウト')
      expect(header.text).to include(user.username)
      expect(header.text).not_to include('ログイン')
      expect(header.text).not_to include('新規登録')
    end
  end
end

