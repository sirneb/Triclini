require 'spork'
require 'test_helper' unless Spork.using_spork?

describe NormalDining do

  before do
    @hall = Factory(:hall)

    @normal_dining = NormalDining.new.tap do |a|
      a.hall_id = @hall.id
      a.default_capacity = 1000
      a.reservable = true
    end
  end


  describe "default_capacity field" do
    it "should not be blank" do
      @normal_dining.default_capacity = ""

      refute @normal_dining.valid? 
      assert_match(/blank/, @normal_dining.errors[:default_capacity].first)
    end

    it "should be invalid if non-integer" do
      not_integers = ["fu", "bar", "1b1", " ", "one", "#&", "$", "F", 3.3, 0.1]
      not_integers.each do |not_integer|
        @normal_dining.default_capacity = not_integer

        refute @normal_dining.valid?
        assert @normal_dining.errors[:default_capacity].any?
      end
    end

    it "should not be less than zero" do
      zero_or_less = [0, -1, -999]
      zero_or_less.each do |invalid|
        @normal_dining.default_capacity = invalid
        
        refute @normal_dining.valid?
        assert_match(/greater than 0/, @normal_dining.errors[:default_capacity].first)
      end
    end

    it "should be valid with positive integers" do
      valid_inputs = [1, 244, 1000, 99999]
      valid_inputs.each do |valid|
        @normal_dining.default_capacity = valid

        assert @normal_dining.valid?
        refute @normal_dining.errors[:default_capacity].any?
      end
    end
  end

  describe "settings method" do
    before do
      @date = Date.today
      @normal_dining.save!

    end

    it "should give the default values if not found in temporary changes" do
      @test = Factory.build(:hall)
      @temp_dining = Factory.build(:normal_dining, :default_capacity => 999, :reservable => true)
      assert_equal(999, @temp_dining.settings(@date)[:capacity])
      assert @temp_dining.settings(@date)[:reservable]

    end

    it "should give temporary changes values if found" do
      @temporary_change = TemporaryChange.new
      @temporary_change.normal_dining_id = @normal_dining.id
      @temporary_change.date = @date
      @temporary_change.changed_capacity = 500
      @temporary_change.changed_reservable = false
      @temporary_change.save!

      assert_equal(500, @normal_dining.settings(@date)[:capacity])
      refute @normal_dining.settings(@date)[:reservable]
    end

    it "should load default values for others if only operation_hours value is filled" do
      skip
    end

    it "should load default values for others if only reservable value is filled" do
      @temporary_change = TemporaryChange.new
      @temporary_change.normal_dining_id = @normal_dining.id
      @temporary_change.date = @date
      @temporary_change.changed_reservable = false
      @temporary_change.save!

      # from default
      assert_equal(@normal_dining.default_capacity, @normal_dining.settings(@date)[:capacity])
      # from temp changes
      refute @normal_dining.settings(@date)[:reservable]
    end

    it "should load default values for others if only capacity value is filled" do
      @temporary_change = TemporaryChange.new
      @temporary_change.normal_dining_id = @normal_dining.id
      @temporary_change.changed_capacity = 500
      @temporary_change.date = @date
      @temporary_change.save!

      # from temp changes
      assert_equal(500, @normal_dining.settings(@date)[:capacity])
      #
      # from default
      assert @normal_dining.settings(@date)[:reservable]
    end
  end
  
  describe "default_operation_hours field" do
    before do
      @op_hash = @normal_dining.default_operation_hours
    end

    it "should create a blank hash on init" do
      refute_nil @op_hash
      assert_equal(7, @op_hash.size )
      (0..6).each do |number|
        assert_includes(@op_hash, Date::DAYNAMES[number])
      end
    end

    it "should allow access to hash correctly" do
      assert_equal(0, @op_hash['Sunday']['open_at'])
      assert_equal(0, @op_hash['Wednesday']['close_at'])
      assert_equal(true, @op_hash['Friday']['closed'])
    end

  end

end
