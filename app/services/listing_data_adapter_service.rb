class ListingDataAdapterService

  def initialize(params)
    @info = params
  end

  def create_listing
    begin
      mls_id          = @info[0]
      summary_info    = @info[1]['summary_attributes'][0]
      detailed_report = @info[1]['detailed_report'][0]
      images_links    = @info[1]['images']
      print_date      = @info[1]['print_date']

      @property =  Property.find_or_create_by(mls_id: mls_id)
      
      # Summary data
      @property.mls_id = mls_id
      @property.address       = summary_info['addr']
      @property.street_name   = parse_address(summary_info['addr'])[:street_name]
      @property.street_number = parse_address(summary_info['addr'])[:street_number]
      @property.longtitude    = summary_info['latitude'].to_f rescue nil
      @property.latitude      = summary_info['longitude'].to_f rescue nil
      @property.municipality  = summary_info['municipality']
      @property.home_type     = summary_info['type_own1_out']
      @property.home_style    = summary_info['style']
      @property.postal        = summary_info['zip']

      # Report data
      @property.for = detailed_report['For:']
      @property.listing_status  = detailed_report['Last Status:']
      @property.leased_date     = parse_date(detailed_report['Leased Date:']) rescue nil
      @property.sold_date = parse_date(detailed_report['Sold Date:']) rescue nil
      @property.apt_unit  = nil
      @property.bedrooms  = detailed_report['Bedrooms:'].to_i rescue nil
      @property.washrooms = detailed_report['Washrooms:'].to_i rescue nil
      @property.kitchens  = detailed_report['Kitchens:'].to_i rescue nil
      @property.sqft_from = nil
      @property.sqft_to   = nil
      @property.basement  = detailed_report['Basement:']
      @property.fronting_on     = detailed_report['Fronting On:']
      @property.family_rooms    = detailed_report['Fam Rm:'].to_i rescue nil
      @property.heat_type       = detailed_report['Heat:']
      @property.air_conditioner = detailed_report['A/C:']
      @property.exterior  = detailed_report['Exterior:']
      @property.drive     = detailed_report['Drive:']
      @property.garage    = detailed_report['Garage:']
      @property.parking_spaces = detailed_report['Park Spcs:'].to_i rescue nil
      @property.water = detailed_report['Water:']
      @property.sewer = detailed_report['Sewers:']
      @property.lot   = detailed_report['Lot:']
      # parse_lot(detailed_report['Lot:'])
      @property.lot_length  = parse_lot(detailed_report['Lot:'])[:length] rescue nil
      @property.lot_width   = parse_lot(detailed_report['Lot:'])[:width] rescue nil
      @property.rooms = detailed_report['Rms:'].to_i rescue nil
      @property.pool  = detailed_report['Pool:']
      @property.cross_streets = detailed_report['Dir/Cross St:']
      # @property.last_status = detailed_report['Basement:']
      # @property.list_price = detailed_report['Basement:']
      # @property.leased_price = detailed_report['Basement:']
      # @property.sale_price  = detailed_report['Basement:']
      # @property.listing_type = detailed_report['Basement:']
      @property.dom   = detailed_report['DOM:']
      @property.taxes = detailed_report['Basement:']
      @property.client_remarks = detailed_report['Client Remks']
      @property.extras = detailed_report['Extras:']

      #@property.extras = nil
      @property.images_links = images_links
      @property.print_date = parse_date(print_date) rescue nil
    rescue     
      puts "Abort action!"
      @property.save!
    end
    @property.save!
  end

  def parse_lot(str_lot)    
    return nil if str_lot.blank?
    arr = str_lot.split(' ')
    hash = {width: arr[0].to_f, length: arr[2].to_f, unit: arr[3]}    
  end

  def parse_date(date_str)
    return nil if date_str.blank?
    date = Date.strptime("1/22/2016","%M/%d/%Y")
  end

  def parse_address(address_str)
    white_space_index = address_str.index(' ')
    street_name   = address_str[white_space_index..address_str.size].strip
    street_number = address_str[0..white_space_index-1].strip
    hash = {street_name: street_name, street_number: street_number}
  end

  def parse_taxes(taxes_str)
    return nil if taxes_str.blank?
    taxes_str[1..taxes_str.size].to_f
  end



end