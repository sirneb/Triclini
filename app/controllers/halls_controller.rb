class HallsController < ApplicationController
  before_filter :load_club

  def index
    @halls = Hall.where("club_id = #{@club.id}")

  end

  def new
    @hall = Hall.new
  end

  def show
    @hall = Hall.find(params[:id])
  end

  def edit
    @hall = Hall.find(params[:id])
  end

  def create
    @hall = Hall.new(params[:hall])
    @hall.club_id = @club.id

    respond_to do |format|
      if @hall.save
        format.html { redirect_to halls_path, notice: 'A new dining hall has been created.' }
      end
    end

  end

  def update

  end
  
  def destroy

  end

end
