
class RegistrationTicketsController < ApplicationController

  def new
    @site = Site.find(params[:site_id])
    @ticket = RegistrationTicket.new
  end

  def create
    @site = Site.find(params[:site_id])
    @ticket = RegistrationTicket.new(params[:registration_ticket])
    render 'registration_tickets/show'
  end


end
