class User < ApplicationRecord
  before_create :generate_unique_user_identifier

  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PHONE_REGEX = /\A\+\d{1,4} \(\d{1,4}\) \d{1,10}-\d{1,10}\z/
  ROLES = %w(Student Admin)

  validates :name,
            presence: {
              message: 'Debe incluir el nombre'
            }

  validates :email,
            presence: {
              message: 'Debe incluir el correo'
            },
            uniqueness: {
              message: 'Este correo ya está registrado'
            },
            format: { 
              with: EMAIL_REGEX,
              message: 'Formato incorrecto de correo'
            }

  validates :phone,
            presence: true

  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }

  validates_inclusion_of :role, in: ROLES, on: :create, message: "Role is not included on list"

  private

  def generate_unique_user_identifier
    self.unique_user_identifier = SecureRandom.uuid
  end
end
