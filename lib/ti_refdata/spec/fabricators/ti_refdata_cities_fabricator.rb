# encoding: utf-8

Fabricator(:city, class_name: TiRefdata::City) do
  code 'NCE'
  name 'Nice'
  latitude 43.70313
  longitude 7.26608
  country
end

Fabricator(:paris, class_name: TiRefdata::City) do
  code 'PAR'
  name 'Paris'
  latitude 48.85341
  longitude 2.3488
  country
end
