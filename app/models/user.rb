class User < ApplicationRecord
  has_secure_password
  has_many :categories, dependent: :destroy


    validates :name, presence: true

    validates :email, format: { with: /\S+@\S+/ },
    uniqueness: {case_sensitive: false}

    validates :username, presence: true,
    format: { with: /\A[A-Z0-9]+\z/i },
    uniqueness: { case_sensitive: false }

    validates :admin, inclusion: { in: [true, false] }


    
    def gravatar_id
      Digest::MD5::hexdigest(email.downcase)
    end

end
