# frozen_string_literal: true

module Admin
  class ArticlesController < AdminController
    include Searchable

    def index
      @pagy, @articles = pagy(
        find_articles,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @article = find_article
      @article_presenter = ArticlePresenter.new(item: @article)
    end

    def new
      @article = Article.new
    end

    def edit
      @article = find_article
      @article_presenter = ArticlePresenter.new(item: @article)
    end

    def create
      @article = Article.new(article_params)

      if @article.save
        flash[:success] = t('success.create', model: 'Article')

        redirect_to admin_articles_path
      else
        flash[:error] = t('errors.create', model: 'Article')

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = find_article
      @article_presenter = ArticlePresenter.new(item: @article)

      if @article.update(article_params)
        flash[:success] = t('success.update', model: 'article')

        redirect_to admin_articles_path
      else
        flash[:error] = t('errors.update', model: 'article')

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = find_article

      if @article.destroy
        flash[:success] = t('success.destroy', model: 'article')
      else
        flash[:error] = t('errors.destroy')
      end

      redirect_to admin_articles_url, status: :see_other
    end

    private

    def find_articles
      Article.order(updated_at: :desc)
    end

    def find_article
      Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :title,
        :content
      )
    end
  end
end
