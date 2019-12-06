class Client < ApplicationRecord
  belongs_to :ivatype
  has_many :phones
end
