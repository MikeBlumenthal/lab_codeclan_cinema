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
    sql = "SELECT *
    FROM titles
    INNER JOIN films
    ON titles.id = films.title_id
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    data = SqlRunner.run( sql, values )
    titles = Title.map_items( data )
    title_array = []
    titles.each { |title| title_array << title.film_title }
    return title_array
  end

  def tickets()
    sql = "SELECT tickets.*
    FROM tickets
    WHERE tickets.customer_id = $1"
    values = [@id]
    tickets_data = SqlRunner.run( sql, values )
    return Ticket.map_items( tickets_data ).count
  end

  def buy_ticket(film)
    if film.customers_count < film.capacity
      @funds -= film.price
      # ticket = Ticket.new({
      #   'customer_id' => self.id,
      #   'film_id' => film.id
      #   })
      # ticket.save
    end
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
