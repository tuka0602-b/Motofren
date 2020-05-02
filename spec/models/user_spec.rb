require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  context "ユーザーが有効な状態になる" do
    it "ユーザー名、メールアドレス、パスワードがある" do
      expect(user).to be_valid
    end
    it "有効な型のメールアドレスである" do
      valid_addresses = %w(
        user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn
      )
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid, "#{valid_address.inspect} 有効でなければなりません"
      end
    end
  end

  context "ユーザーが無効な状態になる" do
    it "ユーザー名がない" do
      user.name = ""
      expect(user).not_to be_valid
    end

    it "ユーザー名が50文字を超える" do
      user.name = "a" * 51
      expect(user).not_to be_valid
    end

    it "メールアドレスがない" do
      user.email = ""
      expect(user).not_to be_valid
    end

    it "メールアドレスが256文字を超える" do
      user.email = "a" * 244 + "@example.com"
      expect(user).not_to be_valid
    end

    it "重複したメールアドレスである" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it "無効な型のメールアドレスである" do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com foo@bar..com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid, "#{invalid_address.inspect} 無効でなければなりません"
      end
    end

    it "パスワードがない" do
      user.password = ""
      expect(user).not_to be_valid
    end

    it "パスワードが6文字以下である" do
      user.password = "a" * 5
      expect(user).not_to be_valid
    end
  end

  it "ユーザー登録時はメールアドレスが全て小文字に変換されること" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.email).to eq user.reload.email
  end
end
