module OmniauthMacros
  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '12345',
      info: {
        name: 'Facebook Mockuser',
        email: 'face@example.com',
      },
    })
  end

  def twitter_mock
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '123545',
      info: {
        name: 'Twitter Mockuser',
        email: 'twi@example.com',
      },
    })
  end

  def google_oauth2_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123577',
      info: {
        name: 'Google Mockuser',
        email: 'goo@example.com',
      },
    })
  end
end
