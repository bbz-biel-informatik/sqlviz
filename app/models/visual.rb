class Visual < ApplicationRecord
  belongs_to :page
  has_many :queries, inverse_of: :visual

  accepts_nested_attributes_for :queries, reject_if: :all_blank, allow_destroy: true

  def identifier
    self.class.name.split(':').last.underscore
  end

  def self.variants
    Rails.application.eager_load!
    Visual.subclasses
  end

  def datasets
    queries.order(:id).map do |query|
      ActiveRecord::Base.connection.exec_query(query.query)
    end
  end
end
