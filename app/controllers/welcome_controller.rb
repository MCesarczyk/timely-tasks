class WelcomeController < ApplicationController
  def index
    render json: { message: "Welcome to the Timely Tasks API" }, status: :ok
  end
end
