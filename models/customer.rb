require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @funds = info['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    ( name, funds )
    VALUES
    ( $1, $2 )
    RETURNING id"
    values = [ @name, @funds ]
    result = SqlRunner.run( sql, values)
    customer = result.first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET ( name, funds ) = ( $1, $2 )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films_data = SqlRunner.run( sql, values )
    return Film.map_items( films_data )
  end

  def films_titles()
    sql = "SELECT films.title
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films_data = SqlRunner.run( sql, values )
    films = Film.map_items( films_data )
    title_array = []
    films.each { |film| title_array << film.title }
    return title_array
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run( sql )
    return Customer.map_items( customers )
  end

  def Customer.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new( customer ) }
  return result
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run( sql )
  end

end
