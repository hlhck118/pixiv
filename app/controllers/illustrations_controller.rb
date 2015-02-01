class IllustrationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :create_hash_data, only: [:new, :create, :edit, :update]
  before_action :load_restrictions, only: [:new, :edit]
  before_action :load_privacy_levels, only: [:new, :edit]

  def index
  end

  def new
    @data[:illustration] = Illustration.new
  end

  def create
    # load illustration association for create new illustration
    # use foreign key in illustration, so need load restriction and privacy_level
    # error if use params[:restriction] and params[:privacy_level]
    restriction = illustration_params[:restriction].nil? ? nil : Restriction.find_by(id: illustration_params[:restriction])
    privacy_level = illustration_params[:privacy_level].nil? ? nil : PrivacyLevel.find_by(id: illustration_params[:privacy_level])

    illustration = Illustration.new(
        image: illustration_params[:image],
        title: illustration_params[:title],
        description: illustration_params[:description],
        restriction: restriction,
        privacy_level: privacy_level)

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
    params[:illustration][:restriction] = Restriction.find_by(
        id: illustration_params[:restriction]
    ) unless illustration.restriction.id == illustration_params[:restriction].to_i

    params[:illustration][:privacy_level] = PrivacyLevel.find_by(
        id: illustration_params[:privacy_level]
    ) unless illustration.privacy_level.id == illustration_params[:privacy_level].to_i

    if illustration.update_attributes(illustration_params)
      flash[:success] = "Illustration Updated!"
      redirect_to edit_illustration_path(illustration)
    else
      @data[:illustration]
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
    params.require(:illustration).permit(:image, :title, :description, :restriction, :privacy_level)
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
