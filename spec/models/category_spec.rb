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

# Comments:
# 1. The file begins by requiring the 'rails_helper' file, which sets up the Rails testing environment.
# 2. RSpec.describe: Defines a test suite for the Category model.
# 3. describe 'factory': Tests related to the category factory.
# 4. it 'is valid': Checks that a category built from the factory is valid.
# 5. describe 'validations': Tests related to model validations.
# 6. it { should validate_presence_of(:name) }: Checks that the name attribute must be present.
# 7. it { should validate_length_of(:description).is_at_least(5) }: Checks that the description attribute has at least 5 characters.
# 8. describe 'attributes': Tests related to model attributes.
# 9. it 'returns the name for a category' and it 'returns the description for a category': Checks that the category's name and description are returned correctly.
# 10. describe 'associations': Tests related to model associations.
# 11. it { should belong_to(:user) } and it { should have_many(:tasks).dependent(:destroy) }: Checks that a category belongs to a user and has many tasks, which should be destroyed when the category is destroyed.
# 12. describe 'dependent destroy': Tests related to the dependent destroy functionality.
# 13. it 'destroys associated tasks when the category is destroyed': Checks that all tasks associated with a category are destroyed when the category is destroyed.
