class HackpadsController < ApplicationController
  def show
    render html: Hackpad.content(params[:pid]).html_safe
  end
end
