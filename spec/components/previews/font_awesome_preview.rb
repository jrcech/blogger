class FontAwesomePreview < ViewComponent::Preview
  def base_font_awesome
    render Elements::FontAwesome::Component.new(
      icon: 'check',
      title: 'Example component title',
      text: '90'
    )
  end
end
