class Visual < ApplicationRecord
  belongs_to :page
  has_many :queries, inverse_of: :visual, dependent: :destroy

  accepts_nested_attributes_for :queries, reject_if: :all_blank, allow_destroy: true

  default_scope { order(position: :asc) }

  def identifier
    self.class.name.split(':').last.underscore
  end

  def self.variants
    Rails.application.eager_load!
    Visual.subclasses
  end

  def self.label
    I18n.t(self.name.split("::").last.downcase)
  end

  def datasets
    db_url = URI.parse(ENV['READONLY_DATABASE_URL'])
    conn = PG.connect(db_url)
    sets = queries.order(:id).map do |query|
      Rails.logger.info "QUERY: #{query.with_limit}"
      begin
        res = conn.exec(query.with_limit)
        OpenStruct.new(
          query_id: query.id,
          fields: res.fields,
          values: res.values
        )
      rescue StandardError => e
        OpenStruct.new(
          error: e.message
        )
      end
    end
    conn.close
    return sets
  end
end
