module Admin
  class TechnologiesController < AdminController
    def index
      @pagy, @technologies = pagy(
        set_technologies,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @technology = set_technology
      @technology_presenter = TechnologyPresenter.new(record: @technology)
    end

    def new
      @technology = Technology.new
    end

    def edit
      @technology = set_technology
      @technology_presenter = TechnologyPresenter.new(record: @technology)
    end

    def create
      @technology = Technology.new(technology_params)

      if @technology.save
        @technology_presenter = TechnologyPresenter.new(record: @technology)

        flash[:success] = t(
          'success.create',
          model: t('models.technologies.one'),
          record: @technology_presenter.title
        )

        redirect_to admin_technology_url(@technology)
      else
        flash[:error] = t('errors.create', model: t('models.technologies.one'))

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @technology = set_technology
      @technology_presenter = TechnologyPresenter.new(record: @technology)

      if @technology.update(technology_params)
        flash[:success] = t(
          'success.update',
          model: t('models.technologies.one'),
          record: @technology_presenter.title
        )

        redirect_to admin_technology_url(@technology)
      else
        flash[:error] = t(
          'errors.update',
          model: t('models.technologies.one'),
          record: @technology_presenter.title
        )

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @technology = set_technology
      @technology_presenter = TechnologyPresenter.new(record: @technology)

      @technology.destroy

      flash[:success] = t(
        'success.destroy',
        model: t('models.technologies.one'),
        record: @technology_presenter.title
      )

      redirect_to admin_technologies_url, status: :see_other
    end

    def search
      @search_query = params[:search_query]

      @pagy, @technologies = pagy(
        set_technologies.search_by(@search_query),
        page: params[:page],
        items: params[:items]
      )

      render :index
    end

    private

    def set_technologies
      if controller_nested?
        @parent = parent_record
        @parent_presenter = parent_presenter.new(record: @parent)

        Technology.includes(technology_assignments: :article).send(scope_method, parent_record).order(updated_at: :desc)
      else
        Technology.includes(technology_assignments: :article).order(updated_at: :desc)
      end
    end

    def set_technology
      Technology.find(params[:id])
    end

    def technology_params
      params.require(:technology).permit(
        :title,
        :shortcut,
        :homepage
      )
    end
  end
end
