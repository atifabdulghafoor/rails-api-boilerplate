module ImplicitEagerLoads
  def implicit_eager_loads(scope)
    eager_load_scope(scope, self.class::DEFAULT_EAGER_LOADS | all_includes)
  end

  def eager_load_scope(scope, includes)
    scope = scope.includes(*includes) if includes.present?
    scope.all
  end

  def all_includes
    splitted_includes.map(&:to_sym)
  end

  def splitted_includes
    @splitted_includes ||=
      params[:include].to_s.split(',').map(&:strip)
  end
end
