module Api
  module V1
    class ProductsController < BaseController
      actions :index, :create, :update, :destroy

      private

      def resource
        @resource ||= Product.find(params[:id])
      end

      def collection
        @collection ||= ProductsCollection.new(Product.all, filter_params).results
      end

      def filter_params
        params.permit(:name, :status, :category, ids: [])
      end

      def permitted_params
        params.permit(:name, :description, :status, :category_id)
      end
    end
  end
end
