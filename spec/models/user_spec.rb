require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    it 'returns the name for a user' do
      user = build(:user, name: 'Chipper')
      expect(user.name).to eq 'Chipper'
    end

    it 'returns the email for a user' do
      user = build(:user, email: 'test@example.com')
      expect(user.email).to eq 'test@example.com'
    end

    it 'returns the username for a user' do
      user = build(:user, username: 'joey')
      expect(user.username).to eq 'joey'
    end

    it 'returns the admin status for a user' do
      admin_user = build(:admin)
      regular_user = build(:user)

      expect(admin_user.admin?).to eq true
      expect(regular_user.admin?).to eq false
    end

    it 'sets and retrieves the password for a user' do
      user = build(:user)
      password = 'new_password'
      user.password = password
      expect(user.password).to eq password
    end

    it 'calculates the Gravatar ID for a user' do
      user = build(:user, email: 'test@example.com')
      expected_gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

      expect(user.gravatar_id).to eq expected_gravatar_id
    end
  end
  
  describe 'validations' do
    it 'validates the presence of name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates the presence of email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'validates the format of email' do
      user = build(:user, email: 'invalid-email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'validates the uniqueness of email' do
      existing_user = create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'validates the presence of username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'validates the format of username' do
      user = build(:user, username: 'InvalidUsername#')
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("is invalid")
    end

    it 'validates the uniqueness of username' do
      existing_user = create(:user) 
      user = build(:user, username: existing_user.username)
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include("has already been taken")
    end

    it 'validates the inclusion of admin' do
      user = build(:user, admin: nil)
      expect(user).not_to be_valid
      expect(user.errors[:admin]).to include("is not included in the list")
    end
    

    it 'validates that password and password_confirmation match' do
      user = build(:user, password: 'password', password_confirmation: 'wrong_password')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe 'associations' do
    it 'has many categories' do
      user = create(:user)
      category1 = create(:category, user: user)
      category2 = create(:category, user: user)

      expect(user.categories.count).to eq(2)
      expect(user.categories).to include(category1)
      expect(user.categories).to include(category2)
    end
  end

  describe '#gravatar_id' do
    it 'returns the correct Gravatar ID' do
      user = build(:user, email: 'test@example.com')
      expected_gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

      expect(user.gravatar_id).to eq(expected_gravatar_id)
    end
  end
end





























# RSpec.describe User, type: :model do
#   subject { 
#     described_class.new(
#       name: "John Doe", 
#       email: "john.doe@example.com",
#       username: "johndoe",
#       password: "password123",
#       password_confirmation: "password123",
#       admin: false
#     ) 
#   }

#   describe "validations" do
#     it "is valid with valid attributes" do
#       expect(subject).to be_valid
#     end

#     it "is valid when admin is true" do
#       subject.admin = true
#       expect(subject).to be_valid
#     end

#     it "is valid when admin is false" do
#       subject.admin = false
#       expect(subject).to be_valid
#     end

#     it "is not valid when admin is nil" do
#       subject.admin = nil
#       expect(subject).to_not be_valid
#     end


#     it "is not valid without a name" do
#       subject.name = nil
#       expect(subject).to_not be_valid
#     end

#     it "is not valid without an email" do
#       subject.email = nil
#       expect(subject).to_not be_valid
#     end

#     it "is not valid without a username" do
#       subject.username = nil
#       expect(subject).to_not be_valid
#     end

#     it "is not valid with a duplicate email" do
#       User.create!(name: "Jane Doe", email: "john.doe@example.com", username: "janedoe", password: "password123", password_confirmation: "password123")
#       expect(subject).to_not be_valid
#     end

#     it "is not valid with a duplicate username" do
#       User.create!(name: "Jane Doe", email: "jane.doe@example.com", username: "johndoe", password: "password123", password_confirmation: "password123")
#       expect(subject).to_not be_valid
#     end
#   end

#   describe "associations" do
#     it { should have_secure_password }
#     it { should have_many(:categories) }
#   end

#   describe "#gravatar_id" do
#     it "returns a MD5 hash of the user's downcased email" do
#       expect(subject.gravatar_id).to eq(Digest::MD5::hexdigest(subject.email.downcase))
#     end
#   end
# end
