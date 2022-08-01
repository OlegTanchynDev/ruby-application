class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('logins/ip', limit: 3, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.ip
    end
  end

  #block
  Rack::Attack.blocklist('block bad UA logins') do |req|
    #req.path == '/users'
  end
end