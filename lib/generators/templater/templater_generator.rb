class TemplaterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def template_model
    directory 'app/views/admin/model', "app/views/admin/#{file_name}"
    directory 'app/components/views/admin/model', "app/components/views/admin/#{file_name}"

    template(
      'app/controllers/admin/model_controller.rb.tt',
      "app/controllers/admin/#{file_name}_controller.rb"
    )

    template(
      'app/models/model.rb.tt',
      "app/models/#{file_name.singularize}.rb"
    )

    template(
      'app/presenters/model_presenter.rb.tt',
      "app/presenters/#{file_name.singularize}_presenter.rb"
    )

    insert_into_file(
      'config/routes.rb',
      "resources :#{file_name}, concerns: %i[searchable]\n",
      after: "namespace :admin do\n"
    )

    template(
      'db/seeds/development/models.seeds.rb.tt',
      "db/seeds/development/#{file_name}.seeds.rb"
    )
  end
end
