class VotesController < ApplicationController
  
  def new
    @vote = Vote.new
  end
  
  def create
    @vote = Vote.new(:user_id, :work_id)

    successful = @work.save 

    if successful
      flash[:success] = "Successfully upvoted for #{@work.title}"
      redirect_to works_path
    else
      flash.now[:error] = "A problem occurred: Could not upvote for #{@work.title}"
      render :new, status: :bad_request
    end

  end
end
