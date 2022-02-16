# frozen_string_literal: true

module Utilities
  module ButtonsHelper
    attr_reader :button, :item, :role

    def new_button
      {
        action: :new,
        path: path_for(:new),
        title: t(
          'actions.new',
          item: t("models.#{model_plural_symbol}.one")
        ),
        icon: action_icon(:new)
      }
    end

    def edit_button
      {
        action: :edit,
        path: path_for(:edit),
        title: t('actions.edit'),
        icon: action_icon(:edit)
      }
    end

    def destroy_button
      {
        action: :destroy,
        path: path_for(:destroy),
        method: :delete,
        title: t('actions.destroy'),
        icon: action_icon(:destroy),
        data: destroy_button_data
      }
    end

    def ellipsis_button(*items)
      @buttons = items
      {
        title: '',
        icon: 'ellipsis-v',
        class: 'btn btn-light',
        caret: false,
        menu_position: :right,
        dropdown_items: dropdown_items
      }
    end

    def role_button
      return nil if item == current_user
      return nil if item.has_cached_role? :owner

      @role = item.to_role
      {
        action: "make_#{@role}".to_sym,
        path: send("make_#{@role}_admin_user_path", item),
        title: t("actions.make_#{@role}"),
        icon: action_icon("make_#{@role}"),
        data: role_button_data
      }
    end

    def button_class
      "#{construct_button_class}#{construct_dropdown_class}"
    end

    private

    def construct_button_class
      return nil if button.key? :dropdown
      return button[:class] if button.key? :class
      return "btn btn-#{bootstrap_class}" if bootstrap_class.present?

      'btn btn-primary'
    end

    def destroy_button_data
      model_translation = t("models.#{model_plural_symbol}.one")
      {
        title: t('confirmations.destroy.title', model: model_translation),
        confirm: t('confirmations.destroy.confirm', item: item.title),
        commit: t('confirmations.destroy.commit', model: model_translation),
        cancel: t('confirmations.destroy.cancel')
      }
    end

    def role_button_data
      {
        turbolinks: false,
        title: t("confirmations.make_#{role}.title",
                 item: t("models.#{model_plural_symbol}.one")),
        confirm: t("confirmations.make_#{role}.confirm",
                   item: item.title),
        commit: t("confirmations.make_#{role}.commit"),
        cancel: t("confirmations.make_#{role}.cancel")
      }
    end
  end
end
