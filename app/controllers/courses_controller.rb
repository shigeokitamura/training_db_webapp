class CoursesController < ApplicationController
  def top
  end

  def search
    if params[:keyword]
      @courses = Course.where("course_title ILIKE ? OR topic ILIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    elsif params[:category]
      @courses = Course.where("category ILIKE ?", "%#{params[:category]}%")
    else
      @courses = Course.all
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course #{@course.course_id} has been successfully created."
      redirect_to course_show_path(id: @course.course_id)
    else
      render 'new'
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "Course #{@course.course_id} has been successfully updated."
      redirect_to course_show_path(id: @course.course_id)
    else
      render 'show'
    end
  end

  def delete
    @course = Course.find(params[:id])
  end

  def destroy
    course = Course.find(params[:id])
    course.destroy
    flash.now[:danger] = "Course #{course.course_id} has been deleted."
    render 'deleted'
  end
  
  private
    def course_params
      params.require(:course).permit(:course_id, :course_title, :topic, :day_length, :price, :level_id, :category)
    end
end
