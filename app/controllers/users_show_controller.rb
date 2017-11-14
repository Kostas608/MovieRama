class UsersShowController < ApplicationController
	def show
		if params[:search_by].present?
      		if params[:search_by]=="created_at"
        		@user = User.find(params[:id])
  				@movies = Movie.where(user_id: @user.id).paginate(page: params[:page], per_page: 3).order('created_at DESC') 
        		respond_to do |format|
        		format.html
        		format.json { render json: @movies }
        		end
     		elsif params[:search_by]=="Number_of_likes"
          		@user = User.find(params[:id])
  				@movies = Movie.where(user_id: @user.id).paginate(page: params[:page], per_page: 3).order('Number_of_likes DESC') 
          		respond_to do |format|
          		format.html
          		format.json { render json: @movies }
          		end
       		elsif params[:search_by]=="Number_of_hates"
          		@user = User.find(params[:id])
  				@movies = Movie.where(user_id: @user.id).paginate(page: params[:page], per_page: 3).order('Number_of_hates DESC') 
          		respond_to do |format|
          		format.html
          		format.json { render json: @movies }
          		end
      		end

    	else
       		@user = User.find(params[:id])
  			  @movies = Movie.where(user_id: @user.id).paginate(page: params[:page], per_page: 2).order('created_at DESC') 
       		respond_to do |format|
       		format.html
       		format.json { render json: @movies }
      		end 
    	end
	end

    def show_liked
        @user = User.find(params[:id])
        @movies_buffer=@user.find_liked_items
        if (@movies_buffer==[]) or (@movies_buffer==nil)
            flash[:notice] =  'This user does not like anything. He does not appreciate anything. So we just reloaded this page'
            redirect_to(:back)

               
            
        elsif params[:search_by].present?
          
          if params[:search_by]=="created_at"



            @movies = @movies_buffer.sort_by {|obj| obj.created_at}
            respond_to do |format|
            format.html
            format.json { render json: @movies }
            end
        elsif params[:search_by]=="Number_of_likes"
              
              @movies = @movies_buffer.sort_by {|obj| obj.number_of_likes}
              respond_to do |format|
              format.html
              format.json { render json: @movies }
              end
          elsif params[:search_by]=="Number_of_hates"
              @movies = @movies_buffer.sort_by {|obj| obj.number_of_hates}
              respond_to do |format|
              format.html
              format.json { render json: @movies }
              end
          end

      else
          @movies = @movies_buffer
          respond_to do |format|
          format.html
          format.json { render json: @movies }
          end 
      end
  end
end
