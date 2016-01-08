class HackpadsController < ApplicationController
  def show
    render text: Hackpad.content(params[:pid]).html_safe
  end
end
