class CommentsController < ApplicationController
    def create
        @advertisement = Advertisement.find(params[:advertisement_id])
        @comment = @advertisement.comments.create(params[:comment].permit(:body))
        redirect_to advertisement_path(@advertisement)
    end

    def destroy
        @advertisement = Advertisement.find(params[:advertisement_id])
        @comment = @advertisement.comments.find(params[:id])
        @comment.destroy
        redirect_to advertisement_path(@advertisement)
    end
end
