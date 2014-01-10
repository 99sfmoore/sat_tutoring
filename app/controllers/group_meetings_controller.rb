class GroupMeetingsController < ApplicationController

  def new
    @groupmeeting = GroupMeeting.new
    @site = Site.find(params[:site_id])
    @num_of_sessions = params[:num_of_sessions].to_i || 0
  end

  def create
    @site = Site.find(params[:site_id])
    num_of_sessions = params[:num_of_sessions].to_i
    num_of_sessions.times do |n|
      @site.group_meetings.build(session_number: params[n.to_s]["number"], date: params[n.to_s]["date"])
    end
    @site.save
    render 'index'
  end

  def index
    @site = Site.find(params[:site_id])
  end

end