require 'fanfeedr'
require 'fanfeedr/event'

module Fanfeedrb
  class League
    attr_reader :id, :name

    def initialize params
      @id = params[:id]
      @name = params[:name]
    end

    def events params
      client = Fanfeedr.new params

      client.events self
    end
  end
end
