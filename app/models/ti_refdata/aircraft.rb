# encoding: utf-8

module TiRefdata
  class Aircraft < ActiveRecord::Base
    attr_accessible :code, :manufacturer , :name
  end
end
