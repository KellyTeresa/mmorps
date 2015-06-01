require "sinatra"
require "openssl"
require 'pry'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}
# binding.pry
def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end

get '/' do
  erb :index
end

post '/' do
  redirect '/'
end
