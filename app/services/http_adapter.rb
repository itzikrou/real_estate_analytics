class HttpAdapter

  def self.post(body, url)
    begin
      HTTParty.post(url,
                {
                  :body => body,
                  :headers => { 'Content-Type' => 'application/json' }
                 })
    rescue => exception
      puts exception
    end
  end

  def self.body(longitude_min, longitude_max, latitude_min, latitude_max)
    "CultureId=1&ApplicationId=1&RecordsPerPage=9&MaximumResults=9&PropertySearchTypeId=1&TransactionTypeId=1&PropertyTypeGroupID=1&LongitudeMin=#{longitude_min}&LongitudeMax=#{longitude_max}&LatitudeMin=#{latitude_min}&LatitudeMax=#{latitude_max}"
  end

end
