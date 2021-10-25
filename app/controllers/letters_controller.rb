class LettersController < ApplicationController
  def show
    @letter = params[:letter]
  end

  def slow
    sleep 5
    @letter = params[:letter]
    render :show
  end
end
