# Wallpaper Controller class
#
# Author:: Nishad
# Update(11/27/17):: [Ben] Added sort order logic

class WallpapersController < ApplicationController
  before_action :set_wallpaper, only: [:show, :edit, :update, :destroy, :update_tags]
  before_filter :authorize!, :only => [:new]
  impressionist :actions=>[:show]

  # GET /wallpapers
  # GET /wallpapers.json
  def index

    # Check if we are searching something
    if params[:search]
      @wallpapers = Wallpaper.search(params[:search])
      # We can't call page on an array, so special check here
      if @wallpapers.class == Array
        @wallpapers = Kaminari.paginate_array(@wallpapers).page(params[:page]).per(28)
      else
        @wallpapers = @wallpapers.page params[:page]
      end
    else
      #If not searching, then choose sorting order
      @wallpapers = Wallpaper.all
      @nishad = @wallpapers.sample 4
      @sortOrder = params[:sortOrder]
      if @sortOrder == 'latest'
        @wallpapers = @wallpapers.order(created_at: :desc)
      elsif @sortOrder == 'top'
        @wallpapers = @wallpapers.order(impressions_count: :desc)
      else
        # Default is priority, which factors in view count as well as time created
        @wallpapers = @wallpapers.order(priority: :desc)
      end
      # Paginate the results
      @wallpapers = @wallpapers.page params[:page]
    end
    respond_to do |format|
      format.html
      format.js { render 'partials/wallpaper_page'}
    end
  end

  def tags
    @wallpapers = Wallpaper.tagged_with(params[:tag])
    @wallpapers = @wallpapers.order(priority: :desc)
    @wallpapers = @wallpapers.page params[:page]
    render :index

  end

  # GET /wallpapers/1
  # GET /wallpapers/1.json
  def show
    @user = current_user
    @wallpaper = Wallpaper.find(params[:id])
    @view_count = @wallpaper.impressionist_count
    @favorites = @wallpaper.favorites
    @favorited_by = @wallpaper.favorited_by
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
    @wallpaper.uploader = current_user
    @wallpaper.set_owner_tag_list_on(current_user, :tags, @wallpaper.tag_list)
    @wallpaper.tag_list.clear
    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to @wallpaper, notice: 'Wallpaper was successfully created.' }
        format.js { redirect_to @wallpaper}
        format.json { render :show, status: :created, location: @wallpaper }
      else
        format.html { render :new }
        format.js {render 'create' }
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

  # PATCH/PUT /wallpapers/1/updatetags
  def update_tags
    respond_to do |format|
      current_user.tag(@wallpaper, :with => params[:taglist], :on => :tags)
      if @wallpaper.save
        format.js { render 'partials/update_tags', status: :ok}
      else
        format.js { render json: @wallpaper.errors, status: :unprocessable_entity}
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

  def favorite
    @user = current_user
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
    @user.favorite!(@wallpaper)
    respond_to do |format|
      format.js { render 'favorite'}
    end
  end

  def unfavorite
    @user = current_user
    @favorite = @user.favorites.find_by_wallpaper_id(params[:wallpaper_id])
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
    @favorite.destroy!
    respond_to do |format|
      format.js { render 'unfavorite'}
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
