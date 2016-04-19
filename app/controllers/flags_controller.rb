class FlagsController < ApplicationController
  before_filter :authenticate_user!

  def check
    @flag = Flag.find_by_uuid(params[:id])
    puts @flag.answer.split(',').include?(params[:answer])  ? "\n\ncorrect\n\n" : "\n\nwrong\n\n"
    # TODO: record submissions
    respond_to do |format|
      format.html { render nothing: true }
      format.js { render nothing: true }
    end
  end
end
