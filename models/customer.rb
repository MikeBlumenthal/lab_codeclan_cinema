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

  def Customer.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new( customer ) }
  return result
  end

end
