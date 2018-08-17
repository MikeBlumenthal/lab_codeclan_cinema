require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @title = info['title']
    @price = info['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    ( title, price )
    VALUES
    ( $1, $2 )
    RETURNING id"
    values = [ @title, @price ]
    result = SqlRunner.run( sql, values)
    film = result.first
    @id = film['id'].to_i
  end


end
