class RegistrationTicket
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  attr_accessor :test, :date, :arrival, :start

  def persisted?
    false
  end

  def initialize(ticket_hash={})
    unless ticket_hash == {}
      @test = ticket_hash[:test]
      @date = Date.parse(ticket_hash[:date])
      @arrival = ticket_hash[:arrival]
      @start = ticket_hash[:start]
    end
  end
end