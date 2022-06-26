# frozen_string_literal: true

module Admin
  class ArticlesController < AdminController
    include Searchable

    def index
      @pagy, @items = pagy(
        find_items,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @item = find_item
      @item_presenter = ArticlePresenter.new(item: @item)
    end

    def new
      @item = Article.new
    end

    def edit
      @item = find_item
      @item_presenter = ArticlePresenter.new(item: @item)
    end

    def create
      @item = Article.new(article_params)

      if @item.save
        flash[:success] = t('success.create', model: 'Article')

        redirect_to admin_articles_path
      else
        flash[:error] = t('errors.create', model: 'Article')

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @item = find_item
      @item_presenter = ArticlePresenter.new(item: @item)

      if @item.update(article_params)
        flash[:success] = t('success.update', model: helpers.model_singular)

        redirect_to admin_articles_path
      else
        flash[:error] = t('errors.update', model: helpers.model_singular)

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @item = find_item

      if @item.destroy
        flash[:success] = t('success.destroy', model: helpers.model_singular)
      else
        flash[:error] = t('errors.destroy')
      end

      redirect_to admin_articles_url, status: :see_other
    end

    private

    def find_items
      Article.order(updated_at: :desc)
    end

    def find_item
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
