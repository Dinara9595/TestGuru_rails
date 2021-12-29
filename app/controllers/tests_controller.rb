class TestsController < ApplicationController
  def index
    render json: { tests: Test.all }
  end

  def show
    render json: { test: Test.find(params[:id]) }
  end
end

