require_relative( 'models/film' )
require_relative( 'models/customer' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new( {
  'name' => 'Tony',
  'funds' => '20'
  } )
customer2 = Customer.new( {
  'name' => 'Gary',
  'funds' => '80'
  } )

customer1.save
customer2.save

film1 = Film.new( {
  'title' => 'The Pink Panther',
  'price' => '5'
  } )

film1.save

ticket1 = Ticket.new( {
  'customer_id' => customer1.id,
  'film_id' => film1.id
  } )
ticket2 = Ticket.new( {
  'customer_id' => customer2.id,
  'film_id' => film1.id
  } )

ticket1.save
ticket2.save


binding.pry
nil
