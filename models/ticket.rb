require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @customer_id = info['customer_id'].to_i
    @film_id = info['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    ( customer_id, film_id )
    VALUES
    ( $1, $2 )
    RETURNING id"
    values = [ @customer_id, @film_id ]
    result = SqlRunner.run( sql, values)
    ticket = result.first
    @id = ticket['id'].to_i
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run( sql )
    return Ticket.map_items( tickets )
  end

  def Ticket.map_items(ticket_data)
  result = ticket_data.map { |ticket| Ticket.new( ticket ) }
  return result
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run( sql )
  end

end
