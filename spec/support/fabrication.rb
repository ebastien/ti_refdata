# encoding: utf-8
require 'fabrication'

Fabrication.configure do |config|
  config.path_prefix = [
    Rails.root.join("../.."),
    Rails.root.join("../../lib/ti_refdata")
  ]
end
