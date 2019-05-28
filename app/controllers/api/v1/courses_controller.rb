module Api
  module V1
    class CoursesController < ApplicationController
      protect_from_forgery except: [:create]

      rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {
          status: "ERROR",
          message: exception
        }
      end
      rescue_from ActionController::ParameterMissing do |exception|
        render json: {
          status: "ERROR",
          message: exception
        }
      end

      def index
        keyword = params[:keyword] ? "%#{params[:keyword]}%" : "%"
        category = params[:category] || "%"

        courses = Course.where("category ILIKE ? AND (course_title ILIKE ? OR topic ILIKE ?)",
                               category, keyword, keyword)
        render json: {
          status: "SUCCESS",
          message: "loaded courses",
          data: courses
        }
      end

      def show
        course = Course.find(params[:id])
        render json: {
          status: "SUCCESS",
          message: "loaded courses",
          data: course
        }
      end

      def create
        course = Course.new(course_params)
        if course.save
          render json: {
            status: "SUCCESS",
            message: "created the course",
            data: course
          }
        else
          render json: {
            status: "ERROR",
            message: "course not saved",
            data: course.errors
          }
        end
      end

      def update
        course = Course.find(params[:id])
        if course.update(course_params)
          render json: {
            status: "SUCCESS",
            message: "updated the course",
            data: course
          }
        else
          render json: {
            status: "ERROR",
            message: course.error
          }
        end
      end

      def destroy
        course = Course.find(params[:id])
        course.destroy
        render json: {
          status: "SUCCESS",
          message: "deleted the course",
          data: post
        }
      end

      private

      def course_params
        params.require(:course).permit(:course_id, :course_title, :topic, :day_length, :price, :level_id, :category)
      end

    end
  end
end
