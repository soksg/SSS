class Public::ReviewsController < ApplicationController
  before_action :authenticate_current_member!, except: [:index, :show]

end