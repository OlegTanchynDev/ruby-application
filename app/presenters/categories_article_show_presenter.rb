class CategoriesArticleShowPresenter
  def categories
    @categories ||= Category.all.limit(50)
  end

  def categories_articles_count
    @categories_articles_count ||= Article.group(:category_id).count
  end

  def date_category_format(category)
    category.created_at.strftime("%d.%m.%Y")
  end

  def category_count(category)
    count = categories_articles_count[category.id.to_s].to_i
    if count > 0
      count
    else
      0
    end
  end
end