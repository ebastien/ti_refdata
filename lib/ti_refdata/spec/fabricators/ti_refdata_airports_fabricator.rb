# encoding: utf-8
require 'ti_refdata/por_manager'

class TiRefdata::Airport
  def name_normalized
    read_attribute(:name_normalized) || TiRefdata::PorManager.normalize_name(name)
  end
end

Fabricator(:airport, class_name: TiRefdata::Airport) do
  code 'CDG'
  name 'Paris - Charles-de-Gaulle'
  latitude 49.01278
  longitude 2.55
  country
  city { Fabricate(:paris) }
end
