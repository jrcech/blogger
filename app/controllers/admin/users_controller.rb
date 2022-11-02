# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    def index
      @pagy, @users = pagy(
        set_users,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @user = set_user
      @user_presenter = UserPresenter.new(item: @user)
    end

    def new
      @user = User.new
    end

    def edit
      @user = set_user
      @user_presenter = UserPresenter.new(item: @user)
    end

    def create
      @user = User.new(user_params)

      if @user.skip_confirmation_notification! && @user.save
        @user_presenter = UserPresenter.new(item: @user)

        flash[:success] = t(
          'success.create',
          model: t('models.users.one'),
          record: @user_presenter.title
        )

        redirect_to admin_user_url(@user)
      else
        flash[:error] = t('errors.create', model: t('models.users.one'))

        render :new, status: :unprocessable_entity
      end
    end

    def update
      @user = set_user
      @user_presenter = UserPresenter.new(item: @user)

      if @user.update(user_params)
        flash[:success] = t(
          'success.update',
          model: t('models.users.one'),
          record: @user_presenter.title
        )

        redirect_to admin_user_url(@user)
      else
        flash[:error] = t(
          'errors.update',
          model: t('models.users.one'),
          record: @user_presenter.title
        )

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = set_user
      @user_presenter = UserPresenter.new(item: @user)

      if @user == current_user
        flash[:error] = t('errors.destroy_yourself')
      else
        @user.destroy

        flash[:success] = t(
          'success.destroy',
          record: @user_presenter.title,
          model: t('models.users.one')
        )
      end

      redirect_to admin_users_url, status: :see_other
    end

    %w[member admin].each do |role|
      define_method("make_#{role}") do
        @user = set_user

        if @user.send("make_#{role}")
          flash[:success] = t('success.change_role', role:)
        else
          flash[:error] = t('errors.change_role')
        end

        redirect_to admin_users_url, status: :see_other
      end
    end

    private

    def set_users
      User.preload(:roles).order(updated_at: :desc)
    end

    def set_user
      User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :first_name,
        :last_name,
        :username,
        :password,
        :password_confirmation
      )
    end
  end
end
