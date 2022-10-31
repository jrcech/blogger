class FontAwesomePreview < ViewComponent::Preview
  def base_font_awesome
    render Icons::FontAwesomeComponent.new(
      icon: 'check',
      title: 'Example component title',
      text: '90'
    )
  end
end
