class Hotel < ActiveRecord::Base
  attr_accessible :address, :city, :country, :name, :zipcode, :mainstreet, :crossstreet, :key, :owner, :image, :hotelID
  has_many :prices, dependent: :destroy

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
end
