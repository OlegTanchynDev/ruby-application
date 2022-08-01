# frozen_string_literal: true

class ArticleIncreaseVisitCounter < ApplicationController
  include Sidekiq::Worker

  def perform(article_id)
    @article = Article.find(article_id)
    @article.visit_count+=1
    @article.save
  end
end
