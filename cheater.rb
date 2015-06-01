require "uri"
require "openssl"

def decode_session(str)
  Marshal.load(URI.decode_www_form_component(str).unpack("m").first)
end

def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end

decode_session("BAh7B0kiD3Nlc3Npb25faWQGOgZFVEkiRWY4YjlhY2UwMjVkMmJhZWY5MTNl%0AN2U4ZmM5NTEzYTcyYzNkNGJlOTEyZDIyMmU5Y2Y4YWU1ZjIzN2E4YzBlMTkG%0AOwBGSSIKaHVtYW4GOwBGaQY%3D%0A--3c309358f706bd4293637b2e3887a549f32d9756")

# result: {"session_id"=>"f8b9ace025d2baef913e7e8fc9513a72c3d4be912d222e9cf8ae5f237a8c0e19", "human"=>1}

score = "'human'=>3"
secret = "nobody_will_ever_find_me"

generate_hmac(score, secret)

# result: cb7e146fd44db25572e4ea518b4353f3e83d5e2d
# should guarantee human victory
# but I can't make it work......

# maybe..... f8b9ace025d2baef913e7e8fc9513a72c3d4be912d222e9cf8ae5f237a8c0e19--cb7e146fd44db25572e4ea518b4353f3e83d5e2d
# I don't know :<
