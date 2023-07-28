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
  
  # Comments:
# 1. FactoryBot.define: This line uses the FactoryBot framework to define a factory for creating test data.
# 2. factory :user: This line defines a factory named :user, which is a blueprint for creating test instances of the User model.
# 3. sequence(:name): A sequence is used here to generate unique names for each user instance created by the factory.
# 4. sequence(:username): A sequence is used here to generate unique usernames for each user instance created by the factory.
# 5. sequence(:email): A sequence is used here to generate unique emails for each user instance created by the factory.
# 6. password and password_confirmation: These lines set the password and the password confirmation for each user instance created by the factory to 'shortpwd123'.
# 7. admin: This line sets the admin status of each user instance to false.
# 8. factory :admin: This nested factory creates an admin user, which inherits all the attributes from the user factory and overrides the admin attribute to true.