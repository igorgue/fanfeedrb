class Event
  attr_reader :id, :name, :date

  def initialize params
    @id = params[:id]
    @date = params[:date]
    @name = params[:name]
  end
end
