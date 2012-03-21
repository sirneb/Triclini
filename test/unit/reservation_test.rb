require 'spork'
require 'test_helper' unless Spork.using_spork?

describe Reservation do

  before do
    @normal_dining = Factory(:normal_dining)
    @event = Factory(:event)
    @user = Factory(:user)

    @time = Time.now
    @date = Date.today

    @reservation = Reservation.new
    # @reservation.creator_id = @user.id
    @reservation.user_id = @user.id
    @reservation.normal_dining_id = @normal_dining.id
    @reservation.date = @date
    @reservation.time = @time
    @reservation.number_of_guests = 5
    # @reservation.isEvent = false
  end

  describe "date field" do

    it "should not be blank" do
      @reservation.date = ""

      refute @reservation.valid?
      assert_match(/blank/, @reservation.errors[:date].first)
    end

    it "should only accept date" do
      @reservation.date = "1" 

      refute @reservation.valid?
      assert_match(/blank/, @reservation.errors[:date].first)
    end
  end

  describe "time field" do

    it "should not be blank" do
      @reservation.time = ""

      refute @reservation.valid?
      assert_match(/blank/, @reservation.errors[:time].first)
    end
  end


  describe "number of guests field" do

    it "should not be blank" do
      @reservation.number_of_guests = ""

      refute @reservation.valid?
      assert_match(/blank/, @reservation.errors[:number_of_guests].first)
    end

    it "should be greater than 0" do
      @reservation.number_of_guests = 0

      refute @reservation.valid?
      assert_match(/greater than 0/, @reservation.errors[:number_of_guests].first)
    end
    
    it "should be valid when greater than 0" do
      @reservation.number_of_guests = 2

      # raise @reservation.errors.first.inspect
      assert @reservation.valid?
    end
  end

  describe "isEvent field" do
    it "should always have a value after save" do
      @reservation.save!

      refute_nil @reservation.isEvent
    end
  end

  describe "normal_dining_id and event_id on create triggers isEvent field" do
    it "makes sure isEvent is true when event_id is active" do
      @reservation.event_id = @event.id
      @reservation.normal_dining_id = nil
      # raise @reservation.inspect
      @reservation.save!

      assert @reservation.isEvent
      assert_nil @reservation.normal_dining_id
      refute_nil @reservation.event_id
    end

    it "makes sure isEvent false when normal_dining_id is active" do
      @reservation.event_id = nil
      @reservation.normal_dining_id = @normal_dining.id
      # raise @reservation.inspect
      @reservation.save!

      refute @reservation.isEvent
      assert_nil @reservation.event_id
      refute_nil @reservation.normal_dining_id
    end

  end

  describe "status updates" do
    it "should create a new status with modified date" do
      @reservation.save!
      assert_empty @reservation.statuses

      @reservation.date += 1
      @reservation.save!

      states = @reservation.statuses.map(&:state)

      refute_empty @reservation.statuses
      assert_includes(JSON.parse(states.first), "date" )
    end

    it "should create a new status with modified time" do
      @reservation.save!
      assert_empty @reservation.statuses

      @reservation.time += 100
      @reservation.save!

      states = @reservation.statuses.map(&:state)

      refute_empty @reservation.statuses
      assert_includes(JSON.parse(states.first), "time" )
    end

    it "should create a new status with modified number of guests" do
      @reservation.save!
      assert_empty @reservation.statuses

      @reservation.number_of_guests += 1
      @reservation.save!
      states = @reservation.statuses.map(&:state)

      refute_empty @reservation.statuses
      assert_includes(JSON.parse(states.first), "number_of_guests" )
    end

    it "should create multiple statuses with modified fields, will also disregard unwanted fields" do
      @reservation.save!
      assert_empty @reservation.statuses

      @reservation.number_of_guests += 1
      @reservation.note = "hello"
      @reservation.time += 100
      @reservation.date += 1
      @reservation.save!
      states = @reservation.statuses.map(&:state)
      states_hash = JSON.parse(states.first)
      # raise states.first.inspect

      refute_empty @reservation.statuses
      assert_equal(3, states_hash.size )
      assert states_hash.has_key?('time')
      assert states_hash.has_key?('date')
      assert states_hash.has_key?('number_of_guests')
      refute states_hash.has_key?('note')
    end
  end

  describe "expected_guests_count method" do
    before do
      created_reservations = FactoryGirl.create_list(:reservation, 20, 
                                                     :date => Date.today, 
                                                     :number_of_guests => 5,
                                                     :normal_dining_id => @normal_dining.id)
    end

    it "should return the total number of guests for the day" do
      skip
    end

  end
end
