class Chat < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :number, use: :slugged

  belongs_to :system_application
  has_many :messages, dependent: :destroy

  validates :number, uniqueness: { scope: [:system_application] }
end
