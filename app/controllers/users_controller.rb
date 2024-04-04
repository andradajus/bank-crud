class UsersController < ApplicationController
  def index
    users = User.includes(:accounts).all
    render json: users.as_json(include: :accounts)
  end
end
