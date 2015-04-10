class AirlineNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :airlines, :name_ascii, :name_normalized
    rename_column :airlines, :name2_ascii, :name2_normalized
    TiRefdata::Airline.find_each do |airline|
      airline.name_normalized.gsub!(/[^a-z]/,' ')
      airline.name2_normalized.gsub!(/[^a-z]/,' ')
      airline.save
    end
  end

  def down
    rename_column :airlines, :name_normalized, :name_ascii
    rename_column :airlines, :name2_normalized, :name2_ascii
  end
end
