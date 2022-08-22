module UserAuthentication
  private

  def set_cookie_to_login_user
    token = SecureRandom.urlsafe_base64
    @user.update(remember_token: Digest::SHA256.hexdigest(token.to_s))
    cookies.permanent[:user_remember_token] = token
  end

  def authenticate
    current_token = encrypt_sha256(cookies[:user_remember_token])
    @current_user = User.find_by(remember_token: current_token)
    @current_user.present?
  end

  def encrypt_sha256(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
