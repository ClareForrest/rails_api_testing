require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { FactoryBot.build(:task) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a difficulty greater than 5' do
      subject.difficulty = 6
      expect(subject).to_not be_valid
    end
  end
end
