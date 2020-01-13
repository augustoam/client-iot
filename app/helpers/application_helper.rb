module ApplicationHelper

  def groups_por_user
    return GroupUser.where(user_id: current_user)
  end

  def link_no_icon_to_edit(path, options = {})
    WViewHelpers::LinkIconTo.new.link_no_icon_to_edit(path, options)
  end
  
  def link_icon_to(path, text, icon, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to(path, text, icon, options)
  end

  def link_icon_to_edit(path)
    WViewHelpers::LinkIconTo.new.link_icon_to_edit(path)
  end

  def link_icon_to_destroy(path, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to_destroy(path, options)
  end

  def link_icon_to_back(path)
    WViewHelpers::LinkIconTo.new.link_icon_to_back(path)
  end

  def link_icon_to_new(path, label, options = {})
    WViewHelpers::LinkIconTo.new.link_icon_to_new(path, label, options)
  end

  def save_button
    render partial: 'shared/button_save'
  end

  # Retorna o nome singular do model traduzido usando i18n.
  #
  # ==== Examples
  #
  #   singular_model_name_for(SpaceshipModel)
  #   # => "Nave Espacial"
  def singular_model_name_for(model)
    model.model_name.human
  end

  # Retorna o nome plural do model traduzido usando i18n.
  #
  # ==== Examples
  #
  #   plural_model_name_for(SpaceshipModel)
  #   # => "Naves Espaciais"
  def plural_model_name_for(model)
    model.model_name.human(count: 2)
  end

  def action_list(model)
    I18n.t('views.actions.list', model: model.model_name.human(count: 2))
  end

  def action_new(model)
    I18n.t('views.actions.new', model: model.model_name.human)
  end

  def action_new_fem(model)
    I18n.t('views.actions.new-fem', model: model.model_name.human)
  end

  def action_back
    I18n.t('views.actions.back')
  end

  def action_edit(model)
    I18n.t('views.actions.edit', model: model.model_name.human)
  end

  def action_do_edit
    I18n.t('views.actions.do_edit')
  end

  def action_show
    I18n.t('views.actions.show')
  end

  def action_delete
    I18n.t('views.actions.delete')
  end

  alias action_index      action_list
  alias action_new_male   action_new
  alias action_new_female action_new_fem


  # Retorna a data formatada como "DD/MM/YYYY".
  # Pode ser invocado como ldate.
  #
  # ==== Examples
  #
  #   human_date(Date.today) # hoje é 07/04/2017
  #   # => 07/04/2017
  def human_date(date, pattern = '%d/%m/%Y')
    sanitize_datetime(date).strftime(pattern) if date
  end

  alias ldate human_date

  # Retorna a data e hora formatada como "DD/MM/YYYY HH:MM".
  # Pode ser invocado como ltime.
  #
  # ==== Examples
  #
  #   human_datetime(DateTime.now) # agora é 07/04/2017 10:30
  #   # => 07/04/2017 10:30
  def human_datetime(time, pattern = '%d/%m/%Y %H:%M')
    sanitize_datetime(time).strftime(pattern) if time
  end

  def t_enum(model, enum, valor)
    if valor
      scope_id = "activerecord.attributes.#{model.to_s.underscore}.#{enum}"
      I18n.t(valor, scope: scope_id)
    end
  end

  alias ltime human_datetime

  private

  def sanitize_datetime(value)
    value.is_a?(String) ? DateTime.parse(value) : value
  end
end
