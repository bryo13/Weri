class WorksController < ApplicationController

	before_action :find_work,only:[:show,:destroy, :edit, :update]
	before_action :authenticate_user!

	def index
		if params[:category].blank?
		@works = Work.all.order("created_at DESC").paginate(page: params[:page], per_page: 1)

	else
		@category_id = Category.find_by(name: params[:category]).id
		@works = Work.where(category_id: @category_id).order("created_at DESC").paginate(page: params[:page], per_page: 1)
	  end
  end

	def new
		@work = current_user.works.build
	end

	def show
		@comments = Comment.where(work_id: @work.id).order("created_at DESC")
		
		if @comments.blank?
			@avg_review = 0
		  else
			@avg_review = @comments.average(:rating)
		  end
	end

	def create
		@work = current_user.works.build(works_params)
		if @work.save
			redirect_to @work
			flash[:success] = "Your Work has been uploaded"
		else
			render 'new'
			flash[:danger] = "Something went wrong, try again"
		end
	end

	def destroy
		@work.destroy
		redirect_to @work
	end

	def update
	    respond_to do |format|
            if @work.update(works_params)
              format.html { redirect_to @work, notice: 'Your work was successfully updated.' }
              
            else
              format.html { render :edit }
            end
          end	
	end

	def search
        @works = Work.all.order("created_at DESC")
        if params[:search]
            @works = Work.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 1)
        else
            @works = Work.all.order("created_at DESC").paginate(page: params[:page], per_page: 1)
        end
    end

	private
        def works_params
            params.require(:work).permit(:name, :category_id, attaches:[])
        end

        def find_work
            @work = Work.find(params[:id])
		end
	end
