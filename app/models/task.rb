class Task < ApplicationRecord
  validates :title, presence: true
  validates :difficulty, 
    numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
