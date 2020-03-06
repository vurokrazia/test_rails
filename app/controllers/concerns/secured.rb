module Secured
  def authenticate_user!
    headers = request.headers
    token_requex = /Bearer (\w+)/
    if headers['Authorization'].present? && headers['Authorization'].match(token_requex)
      token = headers['Authorization'].match(token_requex)[1]
      secure = Token.find_by(token: token)
      if secure
        Current.user = secure.user
        return
      end
    end
    render json: {error: 'Authorized'}, status: :unauthorized
  end
end