# frozen_string_literal: true

module Articles
  class Show < ::Service
    attr_reader :user, :article, :request

    def initialize(user: nil, article: nil, request: nil)
      @user = user
      @article = article
      @request = request
    end

    def call
      return failure if user.blank?
      return failure if article.blank?
      return failure if request.blank?

      ArticleIncreaseVisitCounter.perform_async(article.id)
      if article.visit_count % 10 == 0
        UserMailer.visit_count_email(user.id, article.id, request.host_with_port).deliver
      end

      success()
    end
  end
end
