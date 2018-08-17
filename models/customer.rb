require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @funds = info['funds'].to_i
  end


end
