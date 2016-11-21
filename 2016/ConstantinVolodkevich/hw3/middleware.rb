class Auth
  def initialize(appl)
    @appl = appl
  end
  def call(env)
    begin
      options = { algorithm: 'HS256', iss: JWT_ISSUER}
      bearer = JSON.parse(env['HTTP_AUTHORIZATION'])['token']
      payload, header = JWT.decode bearer, JWT_SECRET, true, options
      env['username'] = [payload['user']['username']]
      p env['username']
      @appl.call(env)
    rescue JWT::DecodeError
      [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
    rescue JWT::ExpiredSignature
      [403, { 'Content-Type' => 'text/plain' }, ['The token has expired.']]
    rescue JWT::InvalidIssuerError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
    rescue JWT::InvalidIatError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
    end

  end
end

