# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Searchable

    def index
      @pagy, @users = pagy(
        find_users,
        page: params[:page],
        items: params[:items]
      )
    end

    def show
      @user = find_user
      @user_presenter = UserPresenter.new(item: @user)
    end

    def new
      @user = User.new
    end

    def edit
      @user = find_user
      @user_presenter = UserPresenter.new(item: @user)
    end

    def create
      @user = User.new user_params

      if @user.skip_confirmation_notification! && @user.save
        flash[:success] = t('success.create', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        flash[:error] = t('errors.create', model: helpers.model_singular)

        render :new
      end
    end

    def update
      @user = find_user
      @user_presenter = UserPresenter.new(item: @user)

      if @user.update user_params
        flash[:success] = t('success.update', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        flash[:error] = t('errors.update', model: helpers.model_singular)

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = find_user

      if @user == current_user
        flash[:error] = t('errors.destroy_yourself')
      elsif @user.destroy
        flash[:success] = t('success.destroy', model: helpers.model_singular)
      else
        flash[:error] = t('errors.destroy')
      end

      redirect_back fallback_location: admin_users_path
    end

    %w[member admin].each do |role|
      define_method("make_#{role}") do
        @user = find_user

        if @user.send("make_#{role}")
          flash[:success] = t('success.change_role', role:)
        else
          flash[:error] = t('errors.change_role')
        end

        redirect_back fallback_location: admin_users_path
      end
    end

    private

    def find_users
      User.preload(:roles).order(updated_at: :desc)
    end

    def find_user
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
