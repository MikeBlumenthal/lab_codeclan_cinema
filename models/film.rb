require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title_id, :show_time, :price , :capacity

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @title_id = info['title_id'].to_i
    @show_time = info['show_time'].to_i
    @price = info['price'].to_i
    @capacity = info['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO films
    ( title_id, show_time, price, capacity )
    VALUES
    ( $1, $2, $3, $4 )
    RETURNING id"
    values = [ @title_id, @show_time, @price, @capacity ]
    result = SqlRunner.run( sql, values)
    film = result.first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET ( title_id, show_time, price, capacity ) = ( $1, $2, $3, $4 )
    WHERE id = $5"
    values = [@title_id, @show_time, @price, @capacity, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run( sql, values )
    return Customer.map_items( customers_data )
  end

  def customers_names()
    sql = "SELECT customers.name
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run( sql, values )
    customers = Customer.map_items( customers_data )
    name_array = []
    customers.each { |customer| name_array << customer.name }
    return name_array
  end

  def customers_count
    self.customers.count
  end

  def tickets()
    sql = "SELECT tickets.*
    FROM tickets
    WHERE tickets.customer_id = $1"
    values = [@id]
    tickets_data = SqlRunner.run( sql, values )
    return Ticket.map_items( tickets_data )
  end

  def Film.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run( sql )
    return Film.map_items( films )
  end

  def Film.showings()
    sql = "SELECT
    titles.film_title as FILM,
    films.show_time as TIME
    FROM titles
    INNER JOIN films
    ON titles.id = films.title_id"
    showings = SqlRunner.run( sql )
    array = []
    showings.each { |showing| array << showing }
    return array
  end

  def Film.most_popular
    films = Film.all
    sorted = films.sort {|film1, film2| film2.tickets.length <=> film1.tickets.length}
    return sorted[0]
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
