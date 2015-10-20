class RetrospectivesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # TODO actions
  
  private
  
  def retrospective_params
    params.require(:retrospective).permitt(:name, :date, :pluses, :minuses, :ideas)
  end
end
