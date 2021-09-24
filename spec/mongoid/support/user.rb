# -*- encoding : utf-8 -*-
class User
  include Mongoid::Document

  field :name, type: String
  validates :name, uniqueness: true
end