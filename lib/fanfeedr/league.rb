require 'fanfeedr/event'

class League
  attr_reader :id, :name

  def initialize params
    @id = params[:id]
    @name = params[:name]
  end

  def events
    raise "not implemented"
  end
end
