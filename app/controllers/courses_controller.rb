class CoursesController < ApplicationController
  def top
  end

  def search
    @courses = Course.all
  end
end
