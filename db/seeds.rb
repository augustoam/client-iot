unless Rails.env.test?

  if Admin.count.zero?
    Admin.create(email: 'admin@admin.com', password: 'amendoim')
  end

  if Usuario.count.zero?
    usuario = Usuario.create(email: 'usuario@usuario.com', password: 'amendoim', admin: 'true')
    usuario.confirm
  end

  fabricante = Fabricante.create(descricao: 'Samsung') if Fabricante.count.zero?

  if Componente.count.zero?
    componente1 = Componente.create(descricao: 'SyncRelay')
    componente2 = Componente.create(descricao: 'SyncInfra')
    componente3 = Componente.create(descricao: 'SyncWeather')
    componente4 = Componente.create(descricao: 'SyncPresence')
  end

  if LayoutControle.count.zero?
    layout1 = LayoutControle.create(descricao: 'nenhum',          tipo_layout: 'nenhum')
    layout2 = LayoutControle.create(descricao: 'Televisão',       tipo_layout: 'televisao')
    layout3 = LayoutControle.create(descricao: 'Ar Condicionado', tipo_layout: 'arcondicionado')
    layout4 = LayoutControle.create(descricao: 'Home Teather',    tipo_layout: 'hometeather')
  end

  if Controle.count.zero?
    controle1 = Controle.create(descricao: 'Nenhum',          fabricante: fabricante, componente: componente1, layout_controle: layout1)
    controle2 = Controle.create(descricao: 'Televisao',       fabricante: fabricante, componente: componente2, layout_controle: layout2)
    controle3 = Controle.create(descricao: 'Ar Condicionado', fabricante: fabricante, componente: componente2, layout_controle: layout3)
    controle3 = Controle.create(descricao: 'Home Teather',    fabricante: fabricante, componente: componente2, layout_controle: layout4)
  end
end
