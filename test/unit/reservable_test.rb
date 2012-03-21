require 'spork'
require 'test_helper' unless Spork.using_spork?

class ReservableModuleTest < MiniTest::Spec

  before do
    @normal_dining = Factory(:normal_dining)
    @normal_dining_other = Factory(:normal_dining)
    @event = Factory(:event)
    @event_other = Factory(:event)
    @date = Date.today
    @time = Time.now
  end

  describe "expected_guests_count method" do
    before do
      #### Normal Dining
      #
      FactoryGirl.create_list(:reservation, 5, 
                              :date => @date, 
                              :time => @time,
                              :number_of_guests => 5,
                              :normal_dining_id => @normal_dining.id)
      
      # tomorrow
      FactoryGirl.create_list( :reservation, 6, 
                               :date => @date+1, 
                               :time => @time,
                               :number_of_guests => 5,
                               :normal_dining_id => @normal_dining.id)

      # before the time
      FactoryGirl.create_list( :reservation, 4, 
                               :date => @date, 
                               :time => @time-100,
                               :number_of_guests => 5,
                               :normal_dining_id => @normal_dining.id)
      #
      # different dining location
      FactoryGirl.create_list( :reservation, 2, 
                               :date => @date, 
                               :time => @time-100,
                               :number_of_guests => 5,
                               :normal_dining_id => @normal_dining_other.id)
      
      #### Events
      #
      FactoryGirl.create_list(:event_reservation, 2, 
                              :date => @date, 
                              :time => @time,
                              :number_of_guests => 5,
                              :event_id => @event.id,
                              :normal_dining_id => nil)
      
      #tomorrow
      FactoryGirl.create_list( :event_reservation, 5, 
                               :date => @date+1, 
                               :time => @time,
                               :number_of_guests => 6,
                               :event_id => @event.id,
                              :normal_dining_id => nil)

      # before the time
      FactoryGirl.create_list( :event_reservation, 6, 
                               :date => @date, 
                               :time => @time-100,
                               :number_of_guests => 5,
                               :event_id => @event.id,
                              :normal_dining_id => nil)
      # different event
      FactoryGirl.create_list( :event_reservation, 7, 
                               :date => @date, 
                               :time => @time-100,
                               :number_of_guests => 5,
                               :event_id => @event_other.id,
                               :normal_dining_id => nil)
    end

    it "should give the expected count of number of guests for the day for that occasion" do
      assert_equal(25, @normal_dining.expected_guests_count(@date, @time))
      assert_equal(30, @normal_dining.expected_guests_count(@date+1, @time))
      assert_equal(45, @normal_dining.expected_guests_count(@date, @time-200))
      assert_equal(10, @normal_dining_other.expected_guests_count(@date, @time-200))
    end

    it "should also work with events model" do
      assert_equal(10, @event.expected_guests_count(@date, @time))
      assert_equal(30, @event.expected_guests_count(@date+1, @time))
      assert_equal(40, @event.expected_guests_count(@date, @time-200))
      assert_equal(35, @event_other.expected_guests_count(@date, @time-200))
    end
    
  end

end
