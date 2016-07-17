class HttpAdapter


  # def self.post
  #   body = "CultureId=1&ApplicationId=1&RecordsPerPage=9&MaximumResults=9&PropertySearchTypeId=1&TransactionTypeId=1&StoreyRange=0-0&BedRange=0-0&BathRange=0-0&LongitudeMin=-79.35522486659376&LongitudeMax=-78.87148310633985&LatitudeMin=43.79679194925649&LatitudeMax=43.9739604670514&SortOrder=A&SortBy=1&viewState=l&CurrentPage=3"

  #   HTTParty.post("https://api2.realtor.ca/Listing.svc/PropertySearch_Post",
  #             { 
  #               :body => body,
  #               :headers => { 'Content-Type' => 'application/json' }
  #              })
  # end

  def self.post(body)
    HTTParty.post("https://api2.realtor.ca/Listing.svc/PropertySearch_Post",
              { 
                :body => body,
                :headers => { 'Content-Type' => 'application/json' }
               })
  end

  def self.body(longitude_min, longitude_max, latitude_min, latitude_max)
    "CultureId=1&ApplicationId=1&RecordsPerPage=9&MaximumResults=9&PropertySearchTypeId=1&TransactionTypeId=1&StoreyRange=0-0&BedRange=0-0&BathRange=0-0&LongitudeMin=#{longitude_min}&LongitudeMax=#{longitude_max}&LatitudeMin=#{latitude_min}&LatitudeMax=#{latitude_max}"
  end



end
