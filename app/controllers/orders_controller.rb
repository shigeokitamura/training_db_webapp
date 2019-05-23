class OrdersController < ApplicationController
  before_action :logged_in_user

  def create
    course = Course.find(params[:bought_id])
    current_user.buy(course)
    redirect_to course_show_path(id: course.course_id)
  end

  def destroy
    course = Order.find(params[:id]).bought
    current_user.cancel(course)
    redirect_to course_show_path(id: course.course_id)
  end
end
