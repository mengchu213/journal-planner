FactoryBot.define do
    factory :user do
      sequence(:name) { |n| "Test User #{n}" }
      sequence(:username) { |n| "testuser#{n}" }
      sequence(:email) { |n| "test#{n}@example.com" }
      password { 'shortpwd123' }
      password_confirmation { 'shortpwd123' }
      admin { false }
  
      factory :admin do
        admin { true }
      end
    end
  end
  