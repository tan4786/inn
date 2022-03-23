class RentalsController < ApplicationController
  before_action :search
  before_action :set_current_user
  
  def top
  end

  def index
    @count= @rentals.count
  end

  def show
    @rental = Rental.find_by(id: params[:id])
    session.delete(:reservation)
    @reservation = Reservation.new
  end
	
  def new
    @rental = @current_user.rentals.new
  end
  
  def create
    @rental = @current_user.rentals.new(
      room: params[:rental][:room],
      description: params[:rental][:description],
      price: params[:rental][:price],
      area: params[:rental][:area],
      address: params[:rental][:address],
      room_image: params[:rental][:room_image],
      owner_id: @current_user.id
      )
    if @rental.save!
      
      @rental.save!
        flash[:notice] = "ルームを登録しました"
        redirect_to("/rentals/#{@current_user.id}/entry")
    else
       flash[:notice] = "登録失敗しました"
      render("rentals/new")
    end
  end
    
  
  def edit
    @rental = @current_user.rentals.find_by(id: params[:user][:user_id])
  end
  
  def update
  @user = User.find(params[:id])
  if @user.update(params.require(:user).permit(:room, :description, :price, :area, :address, :room_image))
    flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
    redirect_to :users
  else
    render "edit"
  end
  end
  
  def destroy
    if @current_user.rentals.find_by(id: params[:rental][:id]).destroy!
      flash[:notice] = "ルームを削除しました"
      redirect_to("/rentals/#{@current_user.id}/entry")
    else
      flash[:notice] = "失敗しました"
      redirect_to("/rentals/#{@current_user.id}/entry")
    end
  end
  
  def entry
    @rentals = @current_user.rentals.all
  end
end
