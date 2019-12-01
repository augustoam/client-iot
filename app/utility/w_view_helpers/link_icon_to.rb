class WViewHelpers::LinkIconTo
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  def link_icon_to(path, text, icon, options = {})
    link_class = options[:link_class]
    method     = options[:method]
    remote     = options[:remote]
    data       = options[:data]
    add_class  = options[:add_class]

    link_to content_tag(:i, icon.to_s, class: 'material-icons ' + add_class.to_s) , path,
            class: link_class, method: method, remote: remote, data: data
  end

  def link_no_icon_to(path, text, options = {})
    link_class = options[:link_class]
    method     = options[:method]
    remote     = options[:remote]
    data       = options[:data]

    link_to text, path, class: link_class, method: method, remote: remote, data: data
  end

  def link_icon_to_edit(path)
    link_icon_to(path, 'Editar', 'edit', add_class: 'icon-hover')
  end

  def link_icon_to_destroy(path, options = {})
    link_icon_to(path, '', 'delete', add_class: 'icon-hover font-delete',
      method: :delete, data: { confirm: 'Você tem certeza?' })
  end

  def link_icon_to_back(path)
    link_icon_to(path, '', 'arrow_back', link_class: 'waves-effect waves-light btn grey')
  end

  def link_icon_to_new(path, label, options = {})
    link_class = options.fetch(:class, 'waves-effect waves-light btn btn-new')
    link_no_icon_to(path, label, link_class: link_class)
  end

  def link_no_icon_to_edit(path, options = {})
    link_class = options.fetch(:class, 'waves-effect waves-light btn btn-new')
    link_no_icon_to(path, 'Editar', link_class: link_class)
  end
end
