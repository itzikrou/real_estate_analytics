class RealtorExtractorService


  def fetch_listings(params)

  end

  def build_msg_body(params)
    msg_params = nil
    params.map{|k,v| "#{k}=#{v}"}.each{|item| msg_params += "&#{item}"}
  end

private

  URL = '"https://api2.realtor.ca/Listing.svc/PropertySearch_Post"'

end