class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_bonstic_cost

  def set_bonstic_cost
    @bonstic_cost = BonsticCost.last
  end
end
