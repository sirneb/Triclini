require 'spork' 
require 'test_helper' unless Spork.using_spork?

describe Club do  

  def setup
    @club = Club.new
    @club.name = "Test Club"
    @club.subdomain = "valid"

  end

  describe "name" do
    it "should not be blank" do
      @club.name = ""

      refute @club.valid?
      assert @club.errors[:name].any?
    end
  end

  describe "subdomain field" do

    it "should not be blank" do
      @club.subdomain = ""

      refute @club.valid?
      assert_match(/blank/, @club.errors[:subdomain].first)
    end

    it "should not allow invalid strings" do
      @invalid_subdomains = %w{a__ 3_aa -bb _ca !Er E?c 88" c:z 3- \ b}
      @invalid_subdomains.each do |invalid|
        @club.subdomain = invalid

        refute @club.valid?
        assert_match(/invalid/, @club.errors[:subdomain].first)
      end
    end

    it "should allow valid string" do
      @valid_subdomains = %w{valid bfw b-c war3 aAa bE-f Uf fubar 333}
      @valid_subdomains.each do |valid|
        @club.subdomain = valid

        assert @club.valid?
      end
    end

    it "should not be less than minimum length" do
      @club.subdomain = "1"

      refute @club.valid? 
      assert_match(/too short/, @club.errors[:subdomain].first)
    end

    it "should not be exceed maximum length" do
      @club.subdomain = "1234567890a"

      refute @club.valid?
      assert_match(/too long/, @club.errors[:subdomain].first)
    end
  end

  describe "assocation/queues" do
    before do
      @club = Factory(:club)
      @hall = Factory(:hall, :club => @club)
      @normal_dining = Factory(:normal_dining, :hall => @hall)
      @event = Factory(:event, :hall => @hall)

      # same club
      FactoryGirl.create_list(:dining_reservation, 20, :normal_dining => @normal_dining )
      FactoryGirl.create_list(:event_reservation, 10, :event => @event)
      
      # different club
      FactoryGirl.create_list(:dining_reservation, 8)
    end

    describe "reservations method" do
      it "should return a Reservation activerecord array with all reservations from the club" do
        assert_equal(30, @club.show_all_reservations.count )
      end
    end

    describe "nested assocation to reservations" do
      it "should return all dining OR event reservations" do 
        assert_equal(20, @club.reservations.count )
        assert_equal(10, @club.event_reservations.count )
        assert_equal(30, (@club.reservations + @club.event_reservations).count )

      end
    end
  end

end
