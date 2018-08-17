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
  
  def update()
    sql = "UPDATE films
    SET ( title, price ) = ( $1, $2 )
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
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

  def Film.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run( sql )
  end

end
