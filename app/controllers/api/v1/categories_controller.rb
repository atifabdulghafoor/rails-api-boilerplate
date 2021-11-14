module Api
  module V1
    class CategoriesController < BaseController
      actions :index, :create

      DEFAULT_EAGER_LOADS = %i[category].freeze

      private

      def collection
        @collection ||= CategoriesCollection.new(Category.all, filter_params).results
      end

      def filter_params
        params.permit(:name, ids: [])
      end

      def permitted_params
        params.permit(:name)
      end
    end
  end
end
