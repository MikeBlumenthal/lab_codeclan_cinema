require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

    def initialize(info)
      @id = info['id'].to_i if info['id']
      @title = info['title']
      @price = info['price'].to_i
    end


end
