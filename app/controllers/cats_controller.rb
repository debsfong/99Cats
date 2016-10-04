class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create

  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end




  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :description, :birth_date)
  end
end
