unless Rails.env.test?

  if Admin.count.zero?
    Admin.create(email: 'admin@admin.com', password: 'amendoim')
  end

  if User.count.zero?
    user = User.create(email: 'user@user.com', password: 'amendoim', admin: 'true')
    user.confirm
  end

  # manufacturer = Manufacturer.create(descricao: 'Samsung') if Manufacturer.count.zero?

  # if Device.count.zero?
  #   device1 = Device.create(descricao: 'SyncRelay')
  #   device2 = Device.create(descricao: 'SyncInfra')
  #   device3 = Device.create(descricao: 'SyncWeather')
  #   device4 = Device.create(descricao: 'SyncPresence')
  # end

  # if ControlLayout.count.zero?
  #   layout1 = ControlLayout.create(descricao: 'nenhum',          tipo_layout: 'nenhum')
  #   layout2 = ControlLayout.create(descricao: 'Televisão',       tipo_layout: 'televisao')
  #   layout3 = ControlLayout.create(descricao: 'Ar Condicionado', tipo_layout: 'arcondicionado')
  #   layout4 = ControlLayout.create(descricao: 'Home Teather',    tipo_layout: 'hometeather')
  # end

  # if Control.count.zero?
  #   control1 = Control.create(descricao: 'Nenhum',          manufacturer: manufacturer, device: device1, layout_control: layout1)
  #   control2 = Control.create(descricao: 'Televisao',       manufacturer: manufacturer, device: device2, layout_control: layout2)
  #   control3 = Control.create(descricao: 'Ar Condicionado', manufacturer: manufacturer, device: device2, layout_control: layout3)
  #   control3 = Control.create(descricao: 'Home Teather',    manufacturer: manufacturer, device: device2, layout_control: layout4)
  # end
end
