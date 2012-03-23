require 'spork'
require 'test_helper' unless Spork.using_spork?

describe Update do

  before do
    @reservation = Factory(:dining_reservation)
    @modifier = Factory(:user)

    @update = Update.new
    @update.user_modifier_id = @modifier.id
    @update.reservation_id = @reservation.id
    @update.state = "something"
  end

  describe "user_modifier_id field" do
    it "links to the modifier user" do
      assert_equal(@modifier, @update.modifier)
    end
  end
  
  describe "state field" do
    it "should not be blank" do
      @update.state = nil

      refute @update.valid?
      assert_match(/blank/, @update.errors[:state].first)
    end
  end


end
