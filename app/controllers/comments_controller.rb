class CommentsController < ApplicationController
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.create! (params[:comment])
    redirect_to @discussion
    
  end
end
