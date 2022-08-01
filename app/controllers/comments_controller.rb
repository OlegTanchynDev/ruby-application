# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:author, :body))
    Article.broadcast_notification({ title: current_user.name, message: 'Has commented on article "'+@article.title+'"' })
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    Article.broadcast_notification({ title: current_user.name, message: 'Has removed comment from article "'+@article.title+'"' })
    redirect_to @article
  end
end
