class CoursesController < ApplicationController
  def top
  end

  def search
    @courses = Course.all
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
      render 'show'
    else
      render 'show'
    end
  end

  def delete
    @course = Course.find(params[:id])
  end

  def destroy
    Course.find(params[:id]).destroy
    render 'deleted'
  end
  
  private
    def course_params
      params.require(:course).permit(:course_id, :course_title, :topic, :day_length, :price, :level_id, :category)
    end
end
