class Product < ApplicationRecord
  # == Constants ============================================================
  STATUS_MAP = { active: 0, inactive: 1 }.freeze
  STATUSES = STATUS_MAP.values

  # == Attributes ===========================================================
  enum status: STATUS_MAP, _default: :active

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :category
  # == Validations ==========================================================
  validates :status, :name, presence: true
  validates :description, length: { maximum: 25 }

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Nested Attributes ====================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
