module Admin
  class ArticlesController < AdminController
    def index
      @pagy, @articles = pagy(
        set_articles,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @article = set_article
      @article_presenter = ArticlePresenter.new(record: @article)
    end

    def new
      @article = Article.new
    end

    def edit
      @article = set_article
      @article_presenter = ArticlePresenter.new(record: @article)
    end

    def create
      @article = current_user.articles.new(article_params)

      if @article.save
        @article_presenter = ArticlePresenter.new(record: @article)

        flash[:success] = t(
          'success.create',
          model: t('models.articles.one'),
          record: @article_presenter.title
        )

        redirect_to admin_article_url(@article)
      else
        flash[:error] = t('errors.create', model: t('models.articles.one'))

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @article = set_article
      @article_presenter = ArticlePresenter.new(record: @article)

      if @article.update(article_params)
        flash[:success] = t(
          'success.update',
          model: t('models.articles.one'),
          record: @article_presenter.title
        )

        redirect_to admin_article_url(@article)
      else
        flash[:error] = t(
          'errors.update',
          model: t('models.articles.one'),
          record: @article_presenter.title
        )

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = set_article
      @article_presenter = ArticlePresenter.new(record: @article)

      @article.destroy

      flash[:success] = t(
        'success.destroy',
        model: t('models.articles.one'),
        record: @article_presenter.title
      )

      redirect_to admin_articles_url, status: :see_other
    end

    def search
      @search_query = params[:search_query]

      @pagy, @articles = pagy(
        set_articles.search_by(@search_query),
        page: params[:page],
        items: params[:items]
      )

      render :index
    end

    private

    def set_articles
      Article.order(updated_at: :desc)
    end

    def set_article
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
