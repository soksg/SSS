class Public::SearchesController < ApplicationController

  private
  def _params
    params.require().permit()
  end
end
