class ProductsCollection < BaseCollection
  private

  def ensure_filters
    filter_by_ids if params[:ids]
    filter_by_name if params[:name]
    filter_by_status if params[:status]
    filter_by_category if params[:category]
  end

  def filter_by_ids
    filter { @relation.where(id: params[:ids]) }
  end

  def filter_by_name
    filter { @relation.where(name: params[:name]) }
  end

  def filter_by_status
    filter { @relation.where(status: params[:status]) }
  end

  def filter_by_category
    filter { @relation.joins(:category).where("categories.name ILIKE '#{params[:category]}%'") }
  end
end
