class BaseCollection
  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      sort_records
      paginate
    end
  end

  private

  def filter
    @relation = yield(@relation)
  end

  def sort_records
    filter { @relation.reorder(params[:order_by].presence || 'created_at' => params[:order].presence || 'desc') }
  end

  # { params: { created_at: { lte: $date_time, gte: $date_time } } }
  def filter_by_time(field)
    return if params[field.to_sym].blank?

    if params[field.to_sym][:gte].present? && params[field.to_sym][:lte].present?
      filter { @relation.where(field => DateTime.parse(params[field.to_sym][:gte])..DateTime.parse(params[field.to_sym][:lte])) }
    elsif params[field.to_sym][:gte].present?
      filter { @relation.where("#{field} >= ?", DateTime.parse(params[field.to_sym][:gte])) }
    else
      filter { @relation.where("#{field} <= ?", DateTime.parse(params[field.to_sym][:lte])) }
    end
  end

  def paginate
    return @relation unless params[:page] && params[:no_pagination].blank?

    @relation.paginate(params[:page], per_page: params[:per_page])
  end

  def ensure_filters; end

  def model
    @relation.model
  end
end
