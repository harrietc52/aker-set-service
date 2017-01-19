class Material

  def self.valid?(uuids)
    conn = get_connection

    response = conn.post do |req|
      req.url '/materials/validate'
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
      req.body = { materials: uuids }.to_json
    end
    response.body == 'ok'
  end

  private

  def self.get_connection
    conn = Faraday.new(:url => 'http://localhost:5000') do |faraday|
      # faraday.use ZipkinTracer::FaradayHandler, 'eve'
      faraday.request  :url_encoded             
      faraday.response :logger                  
      faraday.adapter  Faraday.default_adapter 
      faraday.proxy 'http://localhost:5000'
    end
    conn
  end

end