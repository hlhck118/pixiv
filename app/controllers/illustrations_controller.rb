class IllustrationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_restriction, only: [:new, :edit]
  before_action :load_privacy_level, only: [:new, :edit]

  def index
  end

  def new
    @illustration = Illustration.new
    @restrictions = Restriction.all
    @privacy_level = PrivacyLevel.all
  end

  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.user = current_user
    if @illustration.save
      flash[:success] = "Illustration Uploaded!"
      redirect_to illustration_url(@illustration)
    else
      load_restriction
      load_privacy_level
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
    if @illustration.update_attributes(illustration_params)
      flash[:success] = "Illustration Updated!"
      redirect_to edit_illustration_path(@illustration)
    else
      load_restriction
      load_privacy_level
      render 'edit'
    end
  end

  def destroy
    Illustration.destroy(params[:id])
    flash[:success] = "Illustration deleted!"
    redirect_to user_illustrations(current_user)
  end

  def download
    @illustration = Illustration.find(params[:id])
    style = params[:style].nil? ? :original : params[:style].to_sym
    send_file(
        @illustration.image.path(style),
        file_name: @illustration.image_file_name,
        type: @illustration.image_content_type,
        disposition: "attachment"
    )
  end

  private
  def illustration_params
    params.require(:illustration).permit(:image, :title, :description)
  end

  def load_restriction
    @restrictions = Restriction.all
  end

  def load_privacy_level
    @privacy_level = PrivacyLevel.all
  end
end
