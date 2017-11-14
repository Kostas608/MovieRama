class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new,:create, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    # @movies = Movie.paginate(page: params[:page], per_page: 2).order('created_at DESC')
    if params[:search_by].present?
      if params[:search_by]=="created_at"
        @movies = Movie.paginate(page: params[:page], per_page: 5).order('created_at DESC') 
        respond_to do |format|
        format.html
        format.json { render json: @movies }
        end
      elsif params[:search_by]=="Number_of_likes"
          @movies = Movie.paginate(page: params[:page], per_page: 5).order('Number_of_likes DESC') 
          respond_to do |format|
          format.html
          format.json { render json: @movies }
          end
       elsif params[:search_by]=="Number_of_hates"
          @movies = Movie.paginate(page: params[:page], per_page: 5).order('Number_of_hates DESC') 
          respond_to do |format|
          format.html
          format.json { render json: @movies }
          end
      end

    else
       @movies = Movie.paginate(page: params[:page], per_page: 5).order('created_at DESC') 
       respond_to do |format|
       format.html
       format.json { render json: @movies }
      end 
    end
  end



  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create

    @movie = current_user.movies.create(movie_params)
    @movie.update(Username: current_user.name)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like

    @movie=Movie.find(params[:id])
    if not current_user.present?
      flash[:notice] = 'You cannot like or dislike a movie unless you register to our site'

      redirect_to(:back)

    elsif current_user.voted_up_on? @movie 
      @movie.unliked_by current_user
      @movie.update_attributes(:number_of_likes => @movie.get_likes.size,:number_of_hates => @movie.get_downvotes.size)


      redirect_to(:back)

    
    elsif @movie.user_id==current_user.id
      flash[:notice] = 'You cannot like or deslike your own movie. Have some dignity'

      redirect_to(:back)

    else
      @movie.liked_by current_user
      @movie.update_attributes(:number_of_likes => @movie.get_likes.size,:number_of_hates => @movie.get_downvotes.size)

    # @movies=Movie.all
    # # render json: @movies
      redirect_to(:back)
    end

  end
  def hate
    @movie=Movie.find(params[:id])
    if not current_user.present?
      flash[:notice] = 'You cannot like or dislike a movie unless you register to our site'
      redirect_to(:back)

    elsif current_user.voted_down_on? @movie 
      @movie.undisliked_by current_user
      @movie.update_attributes(:number_of_hates => @movie.get_downvotes.size,:number_of_likes => @movie.get_likes.size)

      redirect_to(:back)

    
    elsif @movie.user_id==current_user.id
      flash[:notice] =  'You cannot like or deslike your own movie. Have some dignity'

      redirect_to(:back)

    else
      @movie.downvote_from current_user
      @movie.update_attributes(:number_of_hates => @movie.get_downvotes.size,:number_of_likes => @movie.get_likes.size)
    # @movies=Movie.all
    # # render json: @movies
    redirect_to(:back)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:Title, :Description)
    end
    def movie_params_update
      params.require(:movie).permit(:Title, :Description, :Publication_date, :Number_of_likes, :Number_of_hates)
    end
end
