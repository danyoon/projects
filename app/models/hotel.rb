class Hotel < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :zipcode, :mainstreet, :crossstreet, :key, :owner, :image, :hotelID
  has_many :prices, dependent: :destroy
  has_many :reverse_connections, foreign_key: "connected_id",
                                   class_name:  "Connection",
                                   dependent:   :destroy
  has_many :connecters, through: :reverse_connections, source: :connecter

  has_many :photos, class_name: 'HotelPhoto'
  has_many :permlinks, class_name: 'HotelPermlink'

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |hotel|
        csv << hotel.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      hotel = find_by_id(row["id"]) || new
      hotel.attributes = row.to_hash.slice(*accessible_attributes)
      hotel.save!
    end
  end

  def self.average_prices(opts=nil)
    prices = Price.joins(:hotel).where(hotel_id: all)
    period =  if opts.is_a? NilClass
                prices.scoped
              elsif opts.is_a? String
                from, to = calculate_quarter_period(opts)
                prices.where(date_for: from..to)
              else
                from, to = opts[:from], opts[:to]
                prices.where(date_for: from..to)
              end

    period.average(:rate)
  end

private
  def self.calculate_quarter_period(quarter)
    year = Date.today.year
    case quarter
    when '1Q'
      from = Date.parse("#{year}-01-01")
      to = Date.parse("#{year}-03-31")
    when '2Q'
      from = Date.parse("#{year}-04-01")
      to = Date.parse("#{year}-06-30")
    when '3Q'
      from = Date.parse("#{year}-07-01")
      to = Date.parse("#{year}-09-30")
    when '4Q'
      from = Date.parse("#{year}-10-01")
      to = Date.parse("#{year}-12-31")
    end
    [from, to]
  end
  
  def self.search(field, search)
    if search
      find(:all, :conditions => [field+" LIKE ?", "%#{search}%"])
    else
      find(:all)
    end
  end
end


