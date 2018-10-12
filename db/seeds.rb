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
    controle1 = Controle.create(descricao: 'Nenhum',          fabricante: fabricante, componente: componente1, layout: layout1)
    controle2 = Controle.create(descricao: 'Televisao',       fabricante: fabricante, componente: componente2, layout: layout2)
    controle3 = Controle.create(descricao: 'Ar Condicionado', fabricante: fabricante, componente: componente2, layout: layout3)
    controle3 = Controle.create(descricao: 'Home Teather',    fabricante: fabricante, componente: componente2, layout: layout4)
  end

  if Grupo.count.zero?
    grupo1 = Grupo.create(nome: 'Casa do Usuário')
  end

  if GrupoUsuario.count.zero?
    GrupoUsuario.create(usuario: usuario, grupo: grupo1)
    # GrupoUsuario.create(usuario: usuario, grupo: grupo2)
  end

  if Ambiente.count.zero?
    ambiente1 = Ambiente.create(descricao: 'Sala', icone: 'week')
  end
  if AmbienteGrupo.count.zero?
    ambiente_grupo1 = AmbienteGrupo.create(nome: 'Sala', grupo: grupo1, ambiente: ambiente1)
    ambiente_grupo1 = AmbienteGrupo.create(nome: 'Cozinha', grupo: grupo1)
    # ambiente3 = Ambiente.create(nome: 'Banheiro', grupo: grupo2)
    # ambiente4 = Ambiente.create(nome: 'Sala Principal', grupo: grupo2)
  end
  # if ControleComponente.count.zero?
  #   controle1 = ControleComponente.create(descricao:'Nenhum')
  #   controle2 = ControleComponente.create(descricao:'Televisao')
  #   controle3 = ControleComponente.create(descricao:'Ar Condicionado')
  # end
  # if Componente.count.zero?
  #   Componente.create(descricao:'Luz de centro', ambiente:ambiente1, controle_componente:controle1)
  #   Componente.create(descricao:'Televisão', ambiente:ambiente1, controle_componente:controle2)
  #   Componente.create(descricao:'Luz da mesa', ambiente:ambiente2, controle_componente:controle1)
  #   Componente.create(descricao:'Geladeira', ambiente:ambiente2, controle_componente:controle1)
  #   Componente.create(descricao:'Luz', ambiente:ambiente3, controle_componente:controle1)
  #   Componente.create(descricao:'Chuveiro', ambiente:ambiente3, controle_componente:controle1)
  #   Componente.create(descricao:'Ar Condicionado', ambiente:ambiente4, controle_componente:controle3)
  #   Componente.create(descricao:'Luz de entrada', ambiente:ambiente4, controle_componente:controle1)
  # end
end
