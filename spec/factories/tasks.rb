FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Task #{n}" }
    description { 'A test task description.' }
    completed { false }
    association :category

    trait :future do
      deadline { 1.week.from_now }
    end

    trait :due_today do
      deadline { Date.today }
    end
  end
end


# Comments:
# 1. FactoryBot.define: This line uses the FactoryBot framework to define a factory for creating test data.
# 2. factory :task: This line defines a factory named :task, which is a blueprint for creating test instances of the Task model.
# 3. sequence(:name): A sequence is used here to generate unique names for each task instance created by the factory.
# 4. description: This line sets the description for each task instance created by the factory to 'A test task description.'.
# 5. completed: This line sets the completed status of each task instance to false.
# 6. association :category: This line defines an association between each task instance and a category instance.
# 7. trait :future: This line defines a trait named :future which sets the deadline for a task instance to be 1 week from the current date/time.
# 8. trait :due_today: This line defines a trait named :due_today which sets the deadline for a task instance to be the current date.