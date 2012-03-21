FactoryGirl.define do
  factory :reservation do
    user
    normal_dining
    number_of_guests {1 + rand(10) }
    sequence :date do |n|
      Date.new(2012,2,1) + n
    end
    time Time.now
  end

  factory :event_reservation, :parent => :reservation do
    user
    event
    number_of_guests {1 + rand(10) }
    sequence :date do |n|
      Date.new(2012,2,1) + n
    end
    time Time.now
  end
end
