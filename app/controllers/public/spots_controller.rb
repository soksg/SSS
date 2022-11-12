class Public::SpotsController < ApplicationController

  private
  def _params
    params.require().permit()
  end
end
