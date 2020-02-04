class Client < ApplicationRecord
  belongs_to :ivatype
  has_many :phones

  validates :ci, presence: true
  validates :name, presence: true
  validates :email, presence: true
#  validate :validateAtLeastOnePhone

=begin
  def validateAtLeastOnePhone
  	return true if phones.any?
  	if phones.empty?
  		errors.add(:base, 'Debe tener al menos un telefono')
  		false
	end
  end
=end  
end
