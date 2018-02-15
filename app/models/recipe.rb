class Recipe < ApplicationRecord
    validates :name, presence: true, length: { maximum: 60 }
    validates :description, presence: true, length: { minimum: 5, maximum: 500 }
    validates :chef_id, presence: true
    belongs_to :chef
end