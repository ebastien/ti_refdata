# encoding: utf-8
require 'ti_refdata/por_manager'

class TiRefdata::Country
  def name_normalized
    read_attribute(:name_normalized) || TiRefdata::PorManager.normalize_name(name)
  end
end

Fabricator(:country, class_name: TiRefdata::Country) do
  code 'FR'
  name 'France'
end
