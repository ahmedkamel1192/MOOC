class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true,uniqueness: true
  validates :email, presence: true,uniqueness: true
  validates :image, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: {male: 0, female: 1, any: 2}

	mount_uploader :image, ImageUploader

end
