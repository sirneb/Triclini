require 'spork'
require 'test_helper' unless Spork.using_spork?

describe Status do

  before do
    @reservation = Factory(:reservation)
    @modifier = Factory(:user)

    @status = Status.new
    @status.user_modifier_id = @modifier.id
    @status.reservation_id = @reservation.id
    @status.state = "something"
  end

  describe "user_modifier_id field" do
    it "links to the modifier user" do
      assert_equal(@modifier, @status.modifier)
    end
  end

end
