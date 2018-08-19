require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )
require_relative( 'models/title' )

require( 'pry-byebug' )

Ticket.delete_all
Film.delete_all
Customer.delete_all
Title.delete_all

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

title1 = Title.new( {
  'film_title' => 'Raising Arizona',
  'age_rating' => '12',
  'genre' => 'comedy'
  } )
title2 =Title.new( {
  'film_title' => 'Con Air',
  'age_rating' => '15',
  'genre' => 'action'
  } )

title1.save
title2.save

film1 = Film.new( {
  'title_id' => title1.id,
  'show_time' => '1700',
  'price' => '5',
  'capacity' => '100'
  } )
film2 = Film.new( {
  'title_id' => title2.id,
  'show_time' => '2000',
  'price' => '10',
  'capacity' => '120'
  } )

film1.save
film2.save

ticket1 = Ticket.new( {
  'customer_id' => customer1.id,
  'film_id' => film1.id
  } )
ticket2 = Ticket.new( {
  'customer_id' => customer2.id,
  'film_id' => film1.id
  } )
ticket3 = Ticket.new( {
  'customer_id' => customer1.id,
  'film_id' => film2.id
  } )

ticket1.save
ticket2.save
ticket3.save

binding.pry
nil
