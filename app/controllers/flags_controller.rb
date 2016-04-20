class FlagsController < ApplicationController
  before_filter :authenticate_user!

  def submissions
    @flag = Flag.find_by_uuid(params[:id])
    @flag_submissions = current_user.flag_submissions.where(flag: @flag).collect(&:submission_text)
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @flag_submissions }
    end
  end

  def check
    @flag = Flag.find_by_uuid(params[:id])
    respond_to do |format|
      if @flag && !params[:answer].blank?
        @flag_submissions = current_user.flag_submissions.where(flag: @flag)
        if @flag.max_attempts > @flag_submissions.count
          @flag_submission = FlagSubmission.create(user: current_user, flag: @flag, submission_text: params[:answer], correct: @flag.answer.split(',').include?(params[:answer]))
          if @flag_submission.save
            if @flag_submission.correct
              format.js { render text: 'Correct!', status: :ok, content_type: 'text/html' }
            else
              format.js { render text: "Incorrect!,#{@flag.max_attempts-@flag_submissions.count},#{@flag_submission.submission_text}", status: :ok, content_type: 'text/html' }
            end
          else
            format.js { render text: 'Submission cound not be saved', status: 403, content_type: 'text/html' }
          end
        else
          format.js { render text: 'Max Attempts Reached', status: 403, content_type: 'text/html' }
        end
      else
        format.js { render text: 'No Answer Provided', status: 403, content_type: 'text/html' }
      end
    end
  end
end
