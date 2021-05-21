class Query < ApplicationRecord
  belongs_to :visual

  def with_limit
    q = query.strip.gsub(/;$/, '')
    if q.downcase.index('limit')
      data = (/limit (\d+)/i).match(q)
      limit = data[1]
      if limit.to_i > 1000
        q.gsub(/limit (\d+)/i, 'LIMIT 1000')
      else
        q
      end
    else
      q + ' LIMIT 1000'
    end
  end

  def self.test
    puts ::Query.new(query: "SELECT * FROM bla LIMIT 2000").with_limit
    puts ::Query.new(query: "SELECT * FROM bla LIMIT 2000;").with_limit
    puts ::Query.new(query: "SELECT * FROM bla LIMIT 3").with_limit
    puts ::Query.new(query: "SELECT * FROM bla LIMIT 3;").with_limit
    puts ::Query.new(query: "SELECT * FROM bla").with_limit
    puts ::Query.new(query: "SELECT * FROM bla;").with_limit
    puts ::Query.new(query: "SELECT * FROM bla limit 3").with_limit
    puts ::Query.new(query: "SELECT * FROM bla limit 3;").with_limit
  end
end
