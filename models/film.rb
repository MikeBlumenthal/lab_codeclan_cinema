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

  def Film.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run( sql )
    return Film.map_items( films )
  end

  def Film.map_items(film_data)
  result = film_data.map { |film| Film.new( film ) }
  return result
  end

end
