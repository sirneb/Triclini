FactoryGirl.define do
  factory :club do
    sequence :name do |n| 
      "Club#{n}"
    end
    sequence :subdomain do |n|
      "club#{n}"
    end

  end

  factory :hall do
    association :club
    sequence :name do |n| 
      "Dining Hall #{n}"
    end
    total_capacity { 1000 + rand(10000) }
    active true
  end

  factory :event do
    association :hall
    sequence :date do |n|
      Date.new(2012,1,1) + n
    end
    sequence :name do |n| 
      "Event #{n}"
    end
    capacity 1000
    reservable true

  end

  factory :normal_dining do
    association :hall
    default_capacity 1000
    reservable true
  end
  
end
