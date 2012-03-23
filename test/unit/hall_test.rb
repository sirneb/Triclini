require 'spork'
require 'test_helper' unless Spork.using_spork?

describe Hall do

  def setup
    @club = FactoryGirl.build(:club)

    @hall = Hall.new
    @hall.club_id = @club.id
    @hall.name = "Fubar"
    @hall.total_capacity = 1000
  end

  describe "name field" do
    it "should not be blank" do
      @hall.name = ""

      refute @hall.valid?
      assert_match(/blank/, @hall.errors[:name].first)
    end
  end

  describe "total_capacity field" do
    it "should not be blank" do
      @hall.total_capacity = ""

      refute @hall.valid?
      assert_match(/blank/, @hall.errors[:total_capacity].first)
    end

    it "should be invalid if non-integer" do
      not_integers = ["fu", "bar", "1b1", " ", "one", "#&", "$", "F", 3.3, 0.1]
      not_integers.each do |not_integer|
        @hall.total_capacity = not_integer

        refute @hall.valid?
        assert @hall.errors[:total_capacity].any?
      end
    end

    it "should not be less than zero" do
      zero_or_less = [0, -1, -999]
      zero_or_less.each do |invalid|
        @hall.total_capacity = invalid
        
        refute @hall.valid?
        assert_match(/greater than 0/, @hall.errors[:total_capacity].first)
      end
    end

    it "should be valid with positive integers" do
      valid_inputs = [1, 244, 1000, 99999]
      valid_inputs.each do |valid|
        @hall.total_capacity = valid

        assert @hall.valid?
        refute @hall.errors[:total_capacity].any?
      end
    end
  end

  describe "active field" do
    it "should be active by default" do
      assert @hall.active
    end
  end

  # describe "events_on method" do
  #   before do
  #     @date = Date.today
  #     @hall.save!

  #     @event1 = Event.new
  #     @event1.date = @date
  #     @event1.hall_id = @hall.id
  #     @event1.name = "Event 1"
  #     @event1.capacity = 500
  #     @event1.save!

  #     @event2 = Event.new
  #     @event2.date = @date
  #     @event2.hall_id = @hall.id
  #     @event2.name = "Event 2"
  #     @event2.capacity = 500
  #     @event2.save!

  #     @event3 = Event.new
  #     @event3.date = Date.yesterday
  #     @event3.hall_id = @hall.id
  #     @event3.name = "Event 2"
  #     @event3.capacity = 500
  #     @event3.save!
  #   end

  #   it "should return an array of events on that date" do
  #     assert_includes(@hall.events_on(@date), @event1)
  #     assert_includes(@hall.events_on(@date), @event2)
  #     refute_includes(@hall.events_on(@date), @event3)
  #     assert_includes(@hall.events_on(Date.yesterday), @event3)
  #   end

  #   it "should return empty if no events on that date" do
  #     assert @hall.events_on(Date.new).empty?
  #   end
  # end
end
