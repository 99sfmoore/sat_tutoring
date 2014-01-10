

class HomeworksController < ApplicationController

  def show
    @homework = Homework.find(params[:id])
    @sections = Hash.new{[]}
    @homework.book_sections.each do |s|
      @sections[s.segment] = @sections[s.segment] << s
    end
  end
end
