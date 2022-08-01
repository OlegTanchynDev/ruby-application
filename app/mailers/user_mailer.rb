# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'otanc@example.com'

  def visit_count_email(user_id, article_id, host_url)
    @user = User.find(user_id)
    @article = Article.find(article_id)
    @host_url = 'http://'+host_url
    mail(to: @user.email, subject: 'Visited site count')
  end
end
