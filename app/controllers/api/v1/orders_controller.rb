module Api
  module V1
    class OrdersController < ApplicationController
      protect_from_forgery except: [:create]

      def index
        orders = Order.all
        render json: {
          status: "SUCCESS",
          message: "loaded orders",
          data: orders
        }
      end

      def create
        course = Course.find_by(course_id: params[:course_id])
        if course
          user = User.find_by(user_name: params[:user_name])
          if user&.authenticate(params[:password])
            user.buy(course)
            render json: {
              status: "SUCCESS",
              message: "order created",
              data: user.active_orders.find_by(bought_id: course.course_id)
            }
          else
            render json: {
              status: "ERROR",
              message: "anthentication failed"
            }
          end
        else
          render json: {
            status: "ERROR",
            message: "course not found"
          }
        end
      end

      private

      def order_params
        params.require(:course_id, :user_id, :password)
      end

    end
  end
end
