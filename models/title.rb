require_relative('../db/sql_runner')

class Title

  attr_reader :id
  attr_accessor :film_title, :age_rating, :genre

  def initialize(info)
    @id = info['id'].to_i
    @film_title = info['film_title']
    @age_rating = info['age_rating']
    @genre = info['genre']
  end

  def save()
    sql = "INSERT INTO titles
    ( film_title, age_rating, genre )
    VALUES
    ( $1, $2, $3 )
    RETURNING id"
    values = [ @film_title, @age_rating, @genre ]
    result = SqlRunner.run( sql, values)
    title = result.first
    @id = title['id'].to_i
  end

  def update()
    sql = "UPDATE titles
    SET ( film_title, age_rating, genre ) = ( $1, $2, $3 )
    WHERE id = $4"
    values = [ @film_title, @age_rating, @genre, @id ]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM titles
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def Title.all()
    sql = "SELECT * FROM titles"
    titles = SqlRunner.run( sql )
    return Title.map_items( titles )
  end

  def Title.map_items(title_data)
  result = title_data.map { |title| Title.new( title ) }
  return result
  end

  def Title.delete_all()
    sql = "DELETE FROM titles"
    SqlRunner.run( sql )
  end


end
