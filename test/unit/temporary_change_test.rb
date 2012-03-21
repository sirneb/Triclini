require 'spork'
require 'test_helper' unless Spork.using_spork?

describe TemporaryChange do

  def setup
    @hall = FactoryGirl.build(:hall)
    @normal_dining = NormalDining.new
    @normal_dining.hall_id = @hall
    @normal_dining.reservable = true
    @normal_dining.default_capacity = 1000

  end

  describe "NormalDining model WITHOUT temporary changes" do 
    it "should show its default values" do
      
    end

  end

  describe "NormalDining model WITH temporary changes" do 
    before do
      @temporary_change = TemporaryChange.new
      @temporary_change.normal_dining_id = @normal_dining.id
      @temporary_change.date = Date.new
      @temporary_change.changed_capacity = 500
      @temporary_change.changed_reservable = false
      @temporary_change.save!
    end

    it "should " do
      # assert true
      assert_includes(@normal_dining.temporary_changes, @temporary_change )
    end
  end

end
