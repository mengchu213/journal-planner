class Task < ApplicationRecord
    belongs_to :category

    validates :name, presence: true
    validates :description, length: { minimum: 25 }
end
