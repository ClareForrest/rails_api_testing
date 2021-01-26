FactoryBot.define do
  factory :task do
    sequence :title do |n|
       "Task no. #{n}" 
    end

    difficulty { 1 }
  end
end
