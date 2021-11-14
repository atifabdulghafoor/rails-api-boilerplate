class CategoriesCollection < BaseCollection
  private

  def ensure_filters
    filter_by_ids if params[:ids]
    filter_by_name if params[:name]
  end

  def filter_by_ids
    filter { @relation.where(id: params[:ids]) }
  end

  def filter_by_name
    filter { @relation.where(name: params[:name]) }
  end
end
