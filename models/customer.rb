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
