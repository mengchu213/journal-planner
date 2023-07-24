class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :description, length: { minimum: 5 }
  validates :completed, inclusion: { in: [true, false] }
  validate :deadline_in_future_or_today

  private

  def deadline_in_future_or_today
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, 'must be today or in the future')
    end
  end
end
