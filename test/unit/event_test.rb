require 'spork'
require 'test_helper' unless Spork.using_spork?

describe Event do

  def setup
    # @club = FactoryGirl.build(:club)
    @hall = FactoryGirl.build(:hall)
    @date = Date.new(2011,10,1)

    @event = Event.new
    @event.name = "Fubar Event"
    @event.date = @date
    @event.hall_id = @hall.id
    @event.capacity = 1000
  end

  describe "name field" do
    it "should not be blank" do
      @event.name = ""

      refute @event.valid?
      assert_match(/blank/, @event.errors[:name].first)
    end
    
  end

  describe "date field" do
    it "should not be blank" do
      @event.date = ""

      refute @event.valid?
      assert_match(/blank/, @event.errors[:date].first)
    end

    it "should not allow non-dates" do
      @event.date = "fubar"

      refute @event.valid?
    end

    it "should allow valid dates" do
      @event.date = Date.tomorrow

      assert @event.valid?
    end
  end

  describe "capacity field" do
    it "should not be blank" do
      @event.capacity = ""

      refute @event.valid? 
      assert_match(/blank/, @event.errors[:capacity].first)
    end

    it "should be invalid if non-integer" do
      not_integers = ["fu", "bar", "1b1", " ", "one", "#&", "$", "F", 3.3, 0.1]
      not_integers.each do |not_integer|
        @event.capacity = not_integer

        refute @event.valid?
        assert @event.errors[:capacity].any?
      end
    end

    it "should not be less than zero" do
      zero_or_less = [0, -1, -999]
      zero_or_less.each do |invalid|
        @event.capacity = invalid
        
        refute @event.valid?
        assert_match(/greater than 0/, @event.errors[:capacity].first)
      end
    end

    it "should be valid with positive integers" do
      valid_inputs = [1, 244, 1000, 99999]
      valid_inputs.each do |valid|
        @event.capacity = valid

        assert @event.valid?
        refute @event.errors[:capacity].any?
      end
    end
  end

  describe "max_party_size field" do
    it "should be zero by default" do
      assert_equal(0, @event.max_party_size)
    end
  end

end
