class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy]
  impressionist :actions=>[:show]
  # GET /wallpapers
  # GET /wallpapers.json
  def index
    @wallpapers = Wallpaper.page params[:page]
    @sortOrder = params[:sortOrder]
    if @sortOrder == 'new'
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
    @tag_list = Wallpaper.find(params[:id]).tag_list
    @wallpaper.priority = @wallpaper.get_priority
    @test = false
    if @wallpaper.save
      @test = true
    end
    @view_count = Wallpaper.find(params[:id]).impressionist_count
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
