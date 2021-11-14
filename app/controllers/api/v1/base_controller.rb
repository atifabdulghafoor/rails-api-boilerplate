module Api
  module V1
    class BaseController < ApplicationController
      include BaseHandler
      include ImplicitEagerLoads

      # For Default Eager Loading
      DEFAULT_EAGER_LOADS = [].freeze

      protected

      def index
        render json: collection, each_serializer: serializer
      end

      def create
        if new_resource.save
          render json: new_resource, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update(permitted_params)
          render json: resource
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if resource.destroy
          render json: resource
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource
      end

      def collection
        @collection ||= implicit_eager_loads(resources)
      end

      def resources
        @resources ||= model.all
      end

      def resource
        @resource ||= model.find(params[:id])
      end

      def new_resource
        @new_resource ||= model.new(permitted_params)
      end

      def serializer
        "#{model}Serializer".constantize
      end
    end
  end
end
