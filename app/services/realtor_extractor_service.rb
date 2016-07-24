class RealtorExtractorService


  def fetch_listings(coords_adjust)
    while true do
      cur_page = 1
      params = req_params
      # coords_adjust = 0.05

      params[:LongitudeMin] = params[:LongitudeMin] - coords_adjust
      params[:LongitudeMax] = params[:LongitudeMax] + coords_adjust
      params[:LatitudeMin] = params[:LatitudeMin] - coords_adjust      
      params[:LatitudeMax] = params[:LatitudeMax] + coords_adjust
      puts "@@@@@@@ Change Coords @@@@@@@@@@@@"
      while true do
        params[:CurrentPage] = cur_page
        body = build_msg_body(params)   
        results = HttpAdapter.post(body, URL) 
        if results['Results'].present?
          results['Results'].each{|result|
            puts " This is the MLS number #{result['MlsNumber']}"
            RealtorEntry.create(mls_id: result['MlsNumber'], data: result)
          }
          cur_page += 1
        else       
          break
        end
      end
    end    
  end


  def fetch_by_address(address, margin)
    cur_page = 1
    params = req_params
    geo_details = Geocoder.search(address).first
    lat = geo_details.data["geometry"]["location"]["lat"]
    lon = geo_details.data["geometry"]["location"]["lng"]
    while true do
      puts "Fetch Page Number: #{cur_page}"
      params[:CurrentPage]  = cur_page
      params[:LongitudeMin] = lon - margin
      params[:LongitudeMax] = lon + margin
      params[:LatitudeMin]  = lat - margin
      params[:LatitudeMax]  = lat + margin
      params[:Latitude]  = lat
      params[:Longitude] = lon
      
      body = build_msg_body(params)   
      results = HttpAdapter.post(body, URL) 
      if results['Results'].present?
        results['Results'].each{|result|
          puts " This is the MLS number #{result['MlsNumber']}"
          RealtorEntry.create(mls_id: result['MlsNumber'], data: result)
        }
        cur_page += 1
      else       
        break
      end
    end
  end

  def req_params
    hash = {
      CultureId: 1,
      ApplicationId: 1,
      RecordsPerPage: 9,
      MaximumResults: 9,
      PropertySearchTypeId: 1,
      TransactionTypeId: 1,
      PropertyTypeGroupID: 1,
      LongitudeMin: -79.4065437316895,
      LongitudeMax: -79.08485031127934,
      LatitudeMin: 43.80401409690893,
      LatitudeMax: 44.00042748004131,
      CurrentPage: 1
    }
  end

  def build_msg_body(params)
    msg_params = ''    
    params.map{|k,v| "#{k}=#{v}"}.each{|item| msg_params += "&#{item}"}
    msg_params
  end

private

  URL = "https://api2.realtor.ca/Listing.svc/PropertySearch_Post"

end


# hash = {
#   CultureId = 1,
#   ApplicationId = 1,
#   RecordsPerPage = 9,
#   MaximumResults = 9,
#   PropertySearchTypeId = 1,
#   TransactionTypeId = 1,
#   PropertyTypeGroupID = 1,
#   LongitudeMin = -79.200927734375,
#   LongitudeMax = -78.85966491699219,
#   LatitudeMin = 43.794797871527976,
#   LatitudeMax = 43.99124160781591,
#   CurrentPage = 1
# }