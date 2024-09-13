module CommentHelper
  def current_comment
    @comment ||= Comment.first
  end
end
