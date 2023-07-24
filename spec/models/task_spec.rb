require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'factory' do
    it 'is valid' do
      task = build(:task)
      expect(task).to be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:description).is_at_least(5) }

    it "validates deadline in the future" do
      task = build(:task, deadline: 1.day.ago)
      task.valid?
      expect(task.errors[:deadline]).to include('must be today or in the future')
    end
  end

  describe 'attributes' do
    it 'returns the name for a task' do
      task = build(:task, name: 'Task 1')
      expect(task.name).to eq 'Task 1'
    end

    it 'returns the description for a task' do
      task = build(:task, description: 'Test description.')
      expect(task.description).to eq 'Test description.'
    end

    it 'returns the completed status for a task' do
      task = build(:task, completed: true)
      expect(task.completed).to eq true
    end

    it 'returns the deadline for a task' do
      deadline = 1.week.from_now
      task = build(:task, deadline: deadline)
      expect(task.deadline).to eq deadline
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }
  end
end