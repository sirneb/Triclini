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
    @reservation.user_id = @user.id
    @reservation.date = @date
    @reservation.time = @time
    @reservation.number_of_guests = 5

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

  describe "polymorphic association with normal_dining and event" do
    before(:each) do
      @reservation2 = Factory(:reservation)
      @normal_dining.reservations << @reservation
      @event.reservations << @reservation2
    end

    it "should be able to get the appropriate associations" do
      assert_equal(@normal_dining, @reservation.reservable )
      refute_equal(@event, @reservation.reservable)
      assert_equal(@event, @reservation2.reservable )
      refute_equal(@normal_dining, @reservation2.reservable)
    end
  end

  # describe "is_event field" do
  #   before do
  #     @reservation.is_event = nil
  #   end

  #   it "should always have a value after save" do
  #     @reservation.save!

  #     refute_nil @reservation.is_event
  #   end
  # end

  describe "status field" do

    it "should not be blank" do
      @reservation.status = nil

      refute @reservation.valid?
      assert_match(/blank/, @reservation.errors[:status].first)
    end

    it "should be set 'unconfirmed' by default" do
      @reservation.save!

      assert_equal(STATUS_VALUES['unconfirmed'], @reservation.status )
    end
  end


  describe "update assocation" do
    it "should create a new update with modified date" do
      @reservation.save!
      assert_empty @reservation.updates

      @reservation.date += 1
      @reservation.save!

      states = @reservation.updates.map(&:state)

      refute_empty @reservation.updates
      assert_includes(JSON.parse(states.first), "date" )
    end

    it "should create a new update with modified time" do
      @reservation.save!
      assert_empty @reservation.updates

      @reservation.time += 100
      @reservation.save!

      states = @reservation.updates.map(&:state)

      refute_empty @reservation.updates
      assert_includes(JSON.parse(states.first), "time" )
    end

    it "should create a new update with modified number of guests" do
      @reservation.save!
      assert_empty @reservation.updates

      @reservation.number_of_guests += 1
      @reservation.save!
      states = @reservation.updates.map(&:state)

      refute_empty @reservation.updates
      assert_includes(JSON.parse(states.first), "number_of_guests" )
    end

    it "should create multiple updates with modified fields, will also disregard unwanted fields" do
      @reservation.save!
      assert_empty @reservation.updates

      @reservation.number_of_guests += 1
      @reservation.note = "hello"
      @reservation.time += 100
      @reservation.date += 1
      @reservation.save!
      states = @reservation.updates.map(&:state)
      states_hash = JSON.parse(states.first)
      # raise states.first.inspect

      refute_empty @reservation.updates
      assert_equal(3, states_hash.size )
      assert states_hash.has_key?('time')
      assert states_hash.has_key?('date')
      assert states_hash.has_key?('number_of_guests')
      refute states_hash.has_key?('note')
    end
  end

  describe "scopes" do
    before do
      @date = Date.today
      @time = Time.now
      FactoryGirl.create_list(:dining_reservation, 10, :status => STATUS_VALUES["confirmed"],
                                                       :date => @date,
                                                       :time => @time)
      FactoryGirl.create_list(:dining_reservation, 15, :status => STATUS_VALUES["unconfirmed"],
                                                       :date => @date,
                                                       :time => @time-800)
      FactoryGirl.create_list(:event_reservation, 5, :status => STATUS_VALUES["confirmed"],
                                                       :date => @date-1,
                                                       :time => @time-1500)
    end

    describe "confirmed" do
      it "should show the confirmed number of reservations" do
        assert_equal(15, Reservation.confirmed.count)
      end
    end
  
    describe "unconfirmed" do
      it "should show the unconfirmed number of reservations" do
        assert_equal(15, Reservation.unconfirmed.count)
      end
    end

    describe "on_date" do
      it "should show all reservations on that date" do
        assert_equal(25, Reservation.on_date(@date).count)
      end

      it "should scope with other scopes" do
        assert_equal(10, Reservation.confirmed.on_date(@date).count )
      end
    end

    describe "before_date" do
      it "should show all reservations on before the date" do
        assert_equal(5, Reservation.before_date(@date).count)
      end
    end

    describe "after_date" do
      it "should show all reservations on after the date" do
        assert_equal(25, Reservation.after_date(@date-1).count)
      end
    end

    describe "on_time" do
      it "should show all reservations on before the time" do
        assert_equal(10, Reservation.on_time(@time).count)
      end
    end

    describe "on_and_before_time" do
      it "should show all reservations on before the time" do
        assert_equal(20, Reservation.on_and_before_time(@time-10).count)
      end
    end

    describe "on_and_after_time" do
      it "should show all reservations on before the time" do
        assert_equal(25, Reservation.on_and_after_time(@time-1000).count)
      end

    end
  end

  
end
