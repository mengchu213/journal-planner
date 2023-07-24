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
