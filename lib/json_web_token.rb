class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, ENV["token_secret_key"], ENV["token_algorithm"])
  end

  def self.decode(token)
    return JWT.decode(token, ENV["token_secret_key"], true, algorithm: ENV["token_algorithm"])[0]
  rescue
    nil
  end
end
