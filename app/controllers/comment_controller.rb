class CommentController < ApplicationController
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    authorize! :read, @comment
  end

  # GET /comments/new
  def new
    @comment = Comment.new(comment_params)
    authorize! :new, @comment
    if @comment.new
      flash[:notice] = "Comment was successful"
      redirect_to @comment
    else
      flash[:error] = "Comment was unsuccessful"
      redirect_to root_path
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    authorize! :edit, @comment
  end

  # POST
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.room_id = params[:room_id]
    if @comment.save
      flash[:notice] = "Comment was successful"
      redirect_to root_path
    else
      flash[:error] = "Comment was unsuccessful"
      redirect_to root_path
    end
  end

  # PUT
  def update
  end

  # DELETE
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, notice: "Comment was successfully destroyed."
  end
end
