class Category < ApplicationRecord

    validates :name, presence: true
    validates :description, length: { minimum: 25 }

end
