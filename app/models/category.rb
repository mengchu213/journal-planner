class Category < ApplicationRecord
    belongs_to :user

    has_many :tasks, dependent: :destroy

    validates :name, presence: true
    validates :description, length: { minimum: 5 }

end
