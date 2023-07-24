require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'factory' do
    it 'is valid' do
      category = build(:category)
      expect(category).to be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:description).is_at_least(5) }
  end

  describe 'attributes' do
    it 'returns the name for a category' do
      category = build(:category, name: 'Category 1')
      expect(category.name).to eq 'Category 1'
    end

    it 'returns the description for a category' do
      category = build(:category, description: 'Test category description.')
      expect(category.description).to eq 'Test category description.'
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks).dependent(:destroy) }
  end

  describe 'dependent destroy' do
    it 'destroys associated tasks when the category is destroyed' do
      category = create(:category)
      task1 = create(:task, category: category)
      task2 = create(:task, category: category)

      expect { category.destroy }.to change(Task, :count).by(-2)
    end
  end
end
