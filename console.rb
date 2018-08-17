require_relative( 'models/film' )
require_relative( 'models/customer' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )


customer1 = Customer.new( {
  'name' => 'Tony',
  'funds' => '20'
  } )
customer1.save


binding.pry
nil
