unless Rails.env.test?

  if Admin.count.zero?
    Admin.create(email: 'admin@admin.com', password: 'amendoim')
  end

  if User.count.zero?
    user = User.create(email: 'user@user.com', password: 'amendoim', admin: 'true')
    user.confirm
  end

  manufacturer = Manufacturer.create(name: 'Samsung') if Manufacturer.count.zero?

  if Room.count.zero?
    Room.create(name: 'Living room')
    Room.create(name: 'Bedroom')
    Room.create(name: 'Bathroom')
    Room.create(name: 'Kitchen')
  end

  if Device.count.zero?
    device1 = Device.create(name: 'SyncRelay',    model: 'SYNCRELAY')
    device2 = Device.create(name: 'SyncInfra',    model: 'SYNCINFRA')
    device3 = Device.create(name: 'SyncWeather',  model: 'SYNCWEATHER')
    device4 = Device.create(name: 'SyncPresence', model: 'SYNCPRESENCE')
  end

  if ControlLayout.count.zero?
    layout1 = ControlLayout.create(name: 'None',            type_name: 'none')
    layout2 = ControlLayout.create(name: 'Television',      type_name: 'television')
    layout3 = ControlLayout.create(name: 'Ar Conditioning', type_name: 'arconditioning')
    layout4 = ControlLayout.create(name: 'Home Teather',    type_name: 'hometeather')
  end

  if Control.count.zero?
    control1 = Control.create(name: 'SyncRelay',       manufacturer: manufacturer, device: device1, control_layout: layout1)
    control2 = Control.create(name: 'Television',      manufacturer: manufacturer, device: device2, control_layout: layout2)
    control3 = Control.create(name: 'Ar Conditioning', manufacturer: manufacturer, device: device2, control_layout: layout3)
    control3 = Control.create(name: 'Home Teather',    manufacturer: manufacturer, device: device2, control_layout: layout4)
  end
end
