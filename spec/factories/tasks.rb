FactoryBot.define do
  factory :task do
    sequence :title do |n|
       "Task no. #{n}" 
    end

    difficulty { 1 }

    trait :invalid do
      title { nil }
    end
  end
end
