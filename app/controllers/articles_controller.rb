# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @q = Article.ransack(params[:q])
    @pagy, @articles = pagy(@q.result, items: 1)
  end

  # GET /articles/1 or /articles/1.json
  def show
    result = Articles::Show.call(user: current_user, article: @article, request: request)
    if result.successful?
      @article = Article.find(params[:id])
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @article }
      end
    else
      render partial: 'templates/404'
    end
  end

  def download_pdf
    filename = '404_pdf'
    page_404 = ApplicationController.new.render_to_string( partial: '/templates/404')
    pdf = Grover.new(page_404, format: 'A5', layout: 'pdf').to_pdf
    send_data pdf, filename: filename, type: 'application/pdf'
    Article.broadcast_notification({ title: current_user.name, message: 'Has downloaded the PDF' })
  end

  # GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  # GET /articles/1/edit
  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.category_id = params[:category_id]
    @categories = Category.all.map{|c| [ c.name, c.id ] }
    #Article.broadcast_notification({ title: current_user.role, message: 'Has created new article' })

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article.category_id = params[:category_id]

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    Article.broadcast_notification({ title: current_user.name, message: 'Has removed article!' })
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :cover_picture)
    end
end
