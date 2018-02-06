class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.all
  end
  def new
    
  end

  def create
    @announcement = Announcement.new(announcement_params)
#(params[:announcement].permit(:title, :text, :contacts))
    @announcement.save
    redirect_to @announcement
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  private
    def announcement_params
      params.require(:announcement).permit(:title, :text, :contacts)
    end
end
