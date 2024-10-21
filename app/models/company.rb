class Company < ApplicationRecord
  before_create :generate_token

  validates :name,
            presence: true,
            length: {
              minimum: 3,
              maximum: 20,
              message: 'Debe tener una longitud menor de 3 y mayor de 20'
            }

  def generate_token
    self.token = SecureRandom.hex
  end
end
