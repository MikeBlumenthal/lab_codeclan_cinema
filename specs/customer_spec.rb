require('minitest/autorun')
require('minitest/rg')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

class TestCustomer < Minitest::Test

  def setup
    @customer1 = Customer.new({
      'id' => '1',
      'name' => 'Danny',
      'funds' => '50'
      })

    @film1 = Film.new({
      'id' => '1',
      'title' => 'Face/Off',
      'price' => '10'
      })
  end

  def test_buy_ticket()
    @customer1.buy_ticket(@film1)
    actual = @customer1.funds
    assert_equal(40, actual)
  end

end
