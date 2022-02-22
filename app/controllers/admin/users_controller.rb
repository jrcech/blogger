# frozen_string_literal: true

module Admin
  class UsersController < AdminController
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
      @item_presenter = UserPresenter.new(item: @item)
    end

    def new
      @item = User.new
    end

    def edit
      @item = find_item
      @item_presenter = UserPresenter.new(item: @item)
    end

    def create
      @item = User.new user_params

      if @item.skip_confirmation_notification! && @item.save
        flash[:success] = t('success.create', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        flash[:error] = t('errors.create', model: helpers.model_singular)

        render :new
      end
    end

    def update
      @item = find_item
      @item_presenter = UserPresenter.new(item: @item)

      if @item.update user_params
        flash[:success] = t('success.update', model: helpers.model_singular)

        redirect_to admin_users_path
      else
        flash[:error] = t('errors.update', model: helpers.model_singular)

        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @item = find_item

      if @item == current_user
        flash[:error] = t('errors.destroy_yourself')
      elsif @item.destroy
        flash[:success] = t('success.destroy', model: helpers.model_singular)
      else
        flash[:error] = t('errors.destroy')
      end

      redirect_back fallback_location: admin_users_path
    end

    %w[member admin].each do |role|
      define_method("make_#{role}") do
        @item = find_item

        if @item.send("make_#{role}")
          flash[:success] = t('success.change_role', role:)
        else
          flash[:error] = t('errors.change_role')
        end

        redirect_back fallback_location: admin_users_path
      end
    end

    private

    def find_items
      User.preload(:roles).order(updated_at: :desc)
    end

    def find_item
      User.find params[:id]
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
