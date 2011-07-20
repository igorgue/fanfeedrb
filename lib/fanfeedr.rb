require 'fanfeedr/league'

class Fanfeedr
  def initialize params
    @api_key = params[:api_key]
    @tier = params[:tier]
  end

  def leagues
    [League.new(:id => 'bla', :name => 'NBA')]
  end
end
