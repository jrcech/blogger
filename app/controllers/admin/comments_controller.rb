module Admin
  class CommentsController < AdminController
    def index
      @pagy, @comments = pagy(
        set_comments,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @comment = set_comment
      @comment_presenter = CommentPresenter.new(record: @comment)
    end

    def new
      @comment = Comment.new
    end

    def edit
      @comment = set_comment
      @comment_presenter = CommentPresenter.new(record: @comment)
    end

    def create
      @comment = current_user.comments.new(comment_params)

      if @comment.save
        @comment_presenter = CommentPresenter.new(record: @comment)

        flash[:success] = t(
          'success.create',
          model: t('models.comments.one'),
          record: @comment_presenter.title
        )

        redirect_to admin_comment_url(@comment)
      else
        flash[:error] = t('errors.create', model: t('models.comments.one'))

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @comment = set_comment
      @comment_presenter = CommentPresenter.new(record: @comment)

      if @comment.update(comment_params)
        flash[:success] = t(
          'success.update',
          model: t('models.comments.one'),
          record: @comment_presenter.title
        )

        redirect_to admin_comment_url(@comment)
      else
        flash[:error] = t(
          'errors.update',
          model: t('models.comments.one'),
          record: @comment_presenter.title
        )

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = set_comment
      @comment_presenter = CommentPresenter.new(record: @comment)

      @comment.destroy

      flash[:success] = t(
        'success.destroy',
        model: t('models.comments.one'),
        record: @comment_presenter.title
      )

      redirect_to admin_comments_url, status: :see_other
    end

    def search
      @search_query = params[:search_query]

      @pagy, @comments = pagy(
        set_comments.search_by(@search_query),
        page: params[:page],
        items: params[:items]
      )

      render :index
    end

    private

    def set_comments
      if controller_nested?
        @parent = parent_record
        @parent_presenter = parent_presenter.new(record: @parent)

        Comment.includes(:article).send(scope_method, parent_record).order(updated_at: :desc)
      else
        Comment.includes(:article).order(updated_at: :desc)
      end
    end

    def set_comment
      Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(
        :title,
        :content,
        :article_id
      )
    end
  end
end
