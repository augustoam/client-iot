unless Rails.env.test?

  if Admin.count.zero?
    Admin.create(email: 'admin@admin.com', password: 'amendoim')
  end

  if User.count.zero?
    user = User.create(email: 'user@user.com', password: 'amendoim', admin: 'true')
    user.confirm
  end

  # manufacturer = Manufacturer.create(name: 'Samsung') if Manufacturer.count.zero?

  # if Device.count.zero?
  #   device1 = Device.create(name: 'SyncRelay')
  #   device2 = Device.create(name: 'SyncInfra')
  #   device3 = Device.create(name: 'SyncWeather')
  #   device4 = Device.create(name: 'SyncPresence')
  # end

  # if ControlLayout.count.zero?
  #   layout1 = ControlLayout.create(name: 'nenhum',          tipo_layout: 'nenhum')
  #   layout2 = ControlLayout.create(name: 'Televisão',       tipo_layout: 'televisao')
  #   layout3 = ControlLayout.create(name: 'Ar Condicionado', tipo_layout: 'arcondicionado')
  #   layout4 = ControlLayout.create(name: 'Home Teather',    tipo_layout: 'hometeather')
  # end

  # if Control.count.zero?
  #   control1 = Control.create(name: 'Nenhum',          manufacturer: manufacturer, device: device1, layout_control: layout1)
  #   control2 = Control.create(name: 'Televisao',       manufacturer: manufacturer, device: device2, layout_control: layout2)
  #   control3 = Control.create(name: 'Ar Condicionado', manufacturer: manufacturer, device: device2, layout_control: layout3)
  #   control3 = Control.create(name: 'Home Teather',    manufacturer: manufacturer, device: device2, layout_control: layout4)
  # end
end
