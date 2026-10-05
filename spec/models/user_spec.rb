require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      username: 'テスト',
      email: 'test@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  describe 'validations' do
    it 'User can be created with valid attributes' do
      expect(user).to be_valid
    end

    context 'when username is blank' do
      it 'is invalid' do
        user.username = ''

        expect(user).not_to be_valid
      end
    end

    context 'when password is less than 3 characters' do
      it 'is invalid' do
        user.password = 'ab'
        user.password_confirmation = 'ab'

        expect(user).not_to be_valid
      end
    end

    context 'when password confirmation is blank' do
      it 'is invalid' do
        user.password_confirmation = ''

        expect(user).not_to be_valid
      end
    end

    context 'when email is blank' do
      it 'is invalid' do
        user.email = ''

        expect(user).not_to be_valid
      end
    end

    context 'when email is duplicated' do
      it 'is invalid' do
        user.save!

        another_user = User.new(
          username: 'test2',
          email: user.email,
          password: 'password',
          password_confirmation: 'password'
        )

        expect(another_user).not_to be_valid
      end
    end

    context 'when password confirmation does not match' do
      it 'is invalid' do
        user.password_confirmation = 'passw0rd'

        expect(user).not_to be_valid
      end
    end
  end
end
