# frozen_string_literal: true

module Admin
  class ReviewsController < AdminController
    def index
      if controller_nested?
        @parent = parent_record
        @parent_presenter = parent_presenter.new(item: @parent)

        @pagy, @reviews = pagy(
          Review.includes(:article).send(scope_method, parent_record).order(updated_at: :desc),
          page: params[:page],
          items: params[:items]
        )
      else
        @pagy, @reviews = pagy(
          Review.includes(:article).order(updated_at: :desc),
          page: params[:page],
          items: params[:items]
        )
      end
    end

    def show
      @review = set_review
      @review_presenter = ReviewPresenter.new(item: @review)
    end

    def new
      @review = Review.new
    end

    def edit
      @review = set_review
      @review_presenter = ReviewPresenter.new(item: @review)
    end

    def create
      @review = Review.new(review_params)

      if @review.save
        @review_presenter = ReviewPresenter.new(item: @review)

        flash[:success] = t(
          'success.create',
          model: t('models.reviews.one'),
          record: @review_presenter.title
        )

        redirect_to admin_review_url(@review)
      else
        flash[:error] = t('errors.create', model: t('models.reviews.one'))

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @review = set_review
      @review_presenter = ReviewPresenter.new(item: @review)

      if @review.update(review_params)
        flash[:success] = t(
          'success.update',
          model: t('models.reviews.one'),
          record: @review_presenter.title
        )

        redirect_to admin_review_url(@review)
      else
        flash[:error] = t(
          'errors.update',
          model: t('models.reviews.one'),
          record: @review_presenter.title
        )

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review = set_review
      @review_presenter = ReviewPresenter.new(item: @review)

      @review.destroy

      flash[:success] = t(
        'success.destroy',
        model: t('models.reviews.one'),
        record: @review_presenter.title
      )

      redirect_to admin_reviews_url, status: :see_other
    end

    def search
      @search_query = params[:search_query]

      @pagy, @reviews = pagy(
        set_reviews.search_by(@search_query),
        page: params[:page],
        items: params[:items]
      )

      render :index
    end

    private

    def set_reviews
      Review.order(updated_at: :desc)
    end

    def set_review
      Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(
        :title,
        :content,
        :article_id
      )
    end
  end
end
