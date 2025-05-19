OmniAuth.config.allowed_request_methods = [:post, :get]

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
      provider :github, "Ov23liYidnkSB9thXfjy", "0ab12f338048bfb06deb8f02fa928b9ed2d55f95"
  else
      provider :github,
        Rails.application.credentials.github[:client_id],
        Rails.application.credentials.github[:client_secret]
  end
end