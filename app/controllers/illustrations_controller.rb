class IllustrationsController < ApplicationController
  def index
  end

  def new
    @illustration = Illustration.new
  end

  def create
    @illustration = Illustration.new(illustration_params)
    if @illustration.save
      flash[:success] = "Illustration Uploaded!"
      redirect_to illustration_url(@illustration)
    else
      render 'new'
    end
  end

  def show
    @illustration = Illustration.find(params[:id])
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end

  def update
    @illustration = Illustration.find(params[:id])
  end

  def destroy
    Illustration.destroy(params[:id])
    flash[:success] = "Illustration deleted!"
    redirect_to illustrations_url
  end

  private
  def illustration_params
    params.require(:illustration).permit(:image, :title, :description)
  end
end
