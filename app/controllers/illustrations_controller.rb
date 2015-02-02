class IllustrationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :create_hash_data, only: [:new, :create, :edit, :update]
  before_action :load_restrictions, only: [:new, :edit]
  before_action :load_privacy_levels, only: [:new, :edit]

  def index
    @illustrations = Illustration.where(user: current_user).order(:created_at => :desc).page(params[:page]).per(12)
  end

  def new
    @data[:illustration] = Illustration.new
  end

  def create
    illustration = Illustration.new(illustration_params)

    illustration.user = current_user
    if illustration.save
      flash[:success] = "Illustration Uploaded!"
      redirect_to illustration_url(illustration)
    else
      @data[:illustration] = illustration
      load_restrictions
      load_privacy_levels
      render 'new'
    end
  end

  def show
    @illustration = Illustration.find(params[:id])
  end

  def edit
    @data[:illustration] = Illustration.find(params[:id])
  end

  def update
    illustration = Illustration.find(params[:id])

    if illustration.update_attributes(illustration_params)
      flash[:success] = "Illustration Updated!"
      redirect_to edit_illustration_path(illustration)
    else
      @data[:illustration] = illustration
      load_restrictions
      load_privacy_levels
      render 'edit'
    end
  end

  def destroy
    Illustration.destroy(params[:id])
    flash[:success] = "Illustration deleted!"
    redirect_to user_illustrations_path(current_user)
  end

  def download
    illustration = Illustration.find(params[:id])
    style = params[:style].nil? ? :original : params[:style].to_sym
    send_file(
        illustration.image.path(style),
        file_name: illustration.image_file_name,
        type: illustration.image_content_type,
        disposition: "attachment"
    )
  end

  private
  def illustration_params
    params.require(:illustration).permit(:image, :title, :description, :restriction_id, :privacy_level_id)
  end

  def create_hash_data
    @data = Hash.new
  end

  def load_restrictions
    @data[:restrictions] = Restriction.all
  end

  def load_privacy_levels
    @data[:privacy_levels] = PrivacyLevel.all
  end

end
