class CoursesController < ApplicationController
  def top
  end

  def search
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def delete
    @course = Course.find(params[:id])
  end
  
end
