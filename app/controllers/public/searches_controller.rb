class Public::SearchesController < ApplicationController
  before_action :authenticate_current_member!, except: [:index, :show]


  private
  def _params
    params.require().permit()
  end
end
