class Admin::GenresController < ApplicationController
  before_action:authenticate_admin!

  def create
    @genre=Genre.new(genre_params)
    if @genre.save
      flash[:notice]="登録に成功しました。"
      redirect_to '/admin/genres'
    else
      @genres=Genre.all
      render:index
    end
  end

  def index
    @genre=Genre.new
    @genres=Genre.all
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice]="変更しました。"
      redirect_to '/admin/genres'
    else
      render:edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
