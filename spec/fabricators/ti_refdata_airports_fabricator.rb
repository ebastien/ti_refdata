# encoding: utf-8

Fabricator(:airport, class_name: TiRefdata::Airport) do
  code 'CDG'
  name 'Paris - Charles-de-Gaulle'
  latitude 49.01278
  longitude 2.55
  country
  city { Fabricate(:paris) }
end
