# Wallpaper Controller class
#
# Author:: Nishad
# Update(11/27/17):: [Ben] Added sort order logic

class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy]
  impressionist :actions=>[:show]

  # GET /wallpapers
  # GET /wallpapers.json
  def index
    @wallpapers = Wallpaper.page params[:page]
    @sortOrder = params[:sortOrder]
    if @sortOrder == 'latest'
      @wallpapers = @wallpapers.order(created_at: :desc)
    elsif @sortOrder == 'top'
      @wallpapers = @wallpapers.order(impressions_count: :desc)
    else
      @wallpapers = @wallpapers.order(priority: :desc)
    end
    respond_to do |format|
      format.html
      format.js { render 'partials/wallpaper_page'}
    end
  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
    @wallpaper = Wallpaper.find(params[:id])
    @tag_list = @wallpaper.tag_list
    @view_count = @wallpaper.impressionist_count
    @wallpaper.update_column(:priority, @wallpaper.get_priority)
  end

  # GET /wallpapers/new
  def new
    @wallpaper = Wallpaper.new
  end

  # GET /wallpapers/1/edit
  def edit
  end


  # POST /wallpapers
  # POST /wallpapers.json
  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    @wallpaper.priority = @wallpaper.get_priority
    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully created.' }
        format.json { render :show, status: :created, location: @wallpaper }
      else
        format.html { render :new }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallpapers/1
  # PATCH/PUT /wallpapers/1.json
  def update
    respond_to do |format|
      if @wallpaper.update(wallpaper_params)
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallpaper }
      else
        format.html { render :edit }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallpapers/1
  # DELETE /wallpapers/1.json
  def destroy
    @wallpaper.destroy
    respond_to do |format|
      format.html { redirect_to wallpapers_url, notice: 'Wallpaper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallpaper
      @wallpaper = Wallpaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallpaper_params
      params.require(:wallpaper).permit(:title, :image, :tag_list)
    end
end
