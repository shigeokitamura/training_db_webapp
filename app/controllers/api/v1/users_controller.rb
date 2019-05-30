module Api
  module V1
    class Api::V1::UsersController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {
          status: "ERROR",
          message: exception
        }
      end

      def show
        user = User.find(params[:id])
        if user
          if user&.authenticate(params[:password])
            orders = user.buying
            total = orders.sum { |hash| hash[:price] }
            render json: {
              status: "SUCCESS",
              message: "loaded orders",
              data: orders,
              total_price: total
            }
          else
            render json: {
              status: "ERROR",
              message: "invalid username/password"
            }
          end
        else
          render json: {
            status: "ERROR",
            message: "user not found"
          }
        end
      end
    end
  end
end
