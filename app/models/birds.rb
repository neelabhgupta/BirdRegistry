class Birds
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date
  field :visible, type: Boolean, default: false

  validates :name, presence: true
  validates :family, presence: true
  validates :added, presence: true
  validate :valid_continents?

  def valid_continents?
    unless continents.present? && continents.length > 0 && continents[0].present?
      errors.add(:continents, 'continents must be of minimum length 1' )
      return false
    else
      return true
    end
  end 
end