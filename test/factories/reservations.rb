FactoryGirl.define do
  factory :reservation do
    user
    number_of_guests {1 + rand(10) }
    sequence :date do |n|
      Date.new(2012,2,1) + n
    end
    time Time.now
    status STATUS_VALUES['unconfirmed']
    waitlist false
  end

  factory :dining_reservation, :parent => :reservation do
    association :reservable, factory: :normal_dining
  end

  factory :event_reservation, :parent => :reservation do
    association :reservable, factory: :event
  end
end

# Factory.define :dining_reservation, :class => "Reservation" do |reservation|
#   reservation.association :reservable, :factory => :normal_dining
# end
