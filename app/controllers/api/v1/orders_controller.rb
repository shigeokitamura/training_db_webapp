module Api
  module V1
    class OrdersController < ApplicationController
      protect_from_forgery except: [:create]

      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {
          status: "ERROR",
          message: exception
        }
      end

      def index
        orders = Order.all
        render json: {
          status: "SUCCESS",
          message: "loaded orders",
          data: orders
        }
      end

      def show
        order = Order.find(params[:id])
        if order
          render json: {
            status: "SUCCESS",
            message: "loaded order",
            data: order
          }
        else
          render json: {
            status: "ERROR",
            message: "order not found"
          }
        end
      end

      def create
        course = Course.find_by(course_id: params[:course_id])
        if course
          user = User.find_by(user_name: params[:user_name])
          if user&.authenticate(params[:password])
            if !user.buying?(course)
              user.buy(course)
              render json: {
                status: "SUCCESS",
                message: "order created",
                data: user.active_orders.find_by(bought_id: course.course_id)
              }
            else
              render json: {
                status: "ERROR",
                message: "you have already ordered the course"
              }
            end
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

      def destroy
        order = Order.find(params[:id])
        if order
          user = User.find_by(user_name: params[:user_name])
          if user&.id == order.buyer_id
            if user&.authenticate(params[:password])
              order.destroy
              render json: {
                status: "SUCCESS",
                message: "deleted the order",
                data: order
              }
            else
              render json: {
                status: "ERROR",
                message: "authentication failed"
              }
            end
          else
            render json: {
              status: "ERROR",
              message: "user is invalid"
            }
          end
        else
          render json: {
            status: "ERROR",
            message: "order not found"
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
