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

  if ControleComando.count.zero?
    ControleComando.create(comando: 'On',         controle: controle1, codigo: 'on')
    ControleComando.create(comando: 'Off',        controle: controle1, codigo: 'off')
    ControleComando.create(comando: 'power-on',   controle: controle2, codigo: '32,9250,4500,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,1650,650,1650,650,1650,650,1650,650,1650,650,1650,650,1650,650,1650,650,1650,650,550,650,1650,650,550,650,550,650,550,650,1650,650,550,650,550,650,1650,650,550,650,1700,650,1650,650,1650,650,550,650,1650,650')
    ControleComando.create(comando: 'power-off',  controle: controle2, codigo: '32,9150,4500,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,1700,600,1650,650,1700,600,1700,600,1700,600,1650,650,1700,600,1650,650,1650,650,1650,650,1700,600,550,650,550,650,550,650,1700,600,550,650,550,650,550,650,550,650,1700,600,1700,600,1700,650,500,650,1650,650')
    ControleComando.create(comando: 'ligth-up',   controle: controle2, codigo: '32,9200,4500,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,1650,650,1650,650,1650,650,1700,600,1650,650,1650,650,1650,650,1650,650,1650,650,550,650,1650,650,550,650,1650,650,550,650,550,650,550,650,550,650,1650,650,550,650,1650,650,550,650,1650,650,1650,650,1650,650')
    ControleComando.create(comando: 'ligth-down', controle: controle2, codigo: '32,9200,4500,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,1650,650,1650,650,1650,650,1650,650,1650,650,1650,650,1700,600,1650,650,1650,650,550,650,550,650,1650,650,550,650,550,650,550,650,550,650,550,650,1700,650,1650,650,550,650,1650,650,1650,650,1650,650,1650,650')
    ControleComando.create(comando: 'rgb-red',    controle: controle2, codigo: '32,9200,4500,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,550,650,1700,600,1650,650,1650,650,1650,650,1700,650,1650,650,1700,600,1650,650,550,650,1650,650,1650,650,550,650,1700,600,550,650,550,650,550,650,1700,600,550,650,550,650,1650,650,550,650,1650,650,1650,650,1650,650')
  end

  if Ambiente.count.zero?
    sala        = Ambiente.create(descricao: 'Sala',           icone: 'weekend')
    banheiro    = Ambiente.create(descricao: 'Banheiro',       icone: 'wc')
    cozinha     = Ambiente.create(descricao: 'Cozinha',        icone: 'restaurant')
    jardim      = Ambiente.create(descricao: 'Jardim',         icone: 'local_florist')
    sala_jantar = Ambiente.create(descricao: 'Sala de Jantar', icone: 'local_dining')
    corredor    = Ambiente.create(descricao: 'view_day',       icone: 'view_day')
    sacada      = Ambiente.create(descricao: 'Sacada',         icone: 'landscape')
    quarto      = Ambiente.create(descricao: 'Quarto',         icone: 'hotel')
    escritorio  = Ambiente.create(descricao: 'Escritório',     icone: 'work')
  end

  if Grupo.count.zero?
    grupo_home = Grupo.create(nome: 'Home')
    grupo_casa = Grupo.create(nome: 'Casa')
  end

  if GrupoUsuario.count.zero?
    GrupoUsuario.create(usuario: usuario, grupo: grupo_home)
    GrupoUsuario.create(usuario: usuario, grupo: grupo_casa)
  end

  if AmbienteGrupo.count.zero?
    ambiente_sala     = AmbienteGrupo.create(nome: 'Sala',     ambiente: sala,     grupo: grupo_home)
    ambiente_banheiro = AmbienteGrupo.create(nome: 'Banheiro', ambiente: banheiro, grupo: grupo_home)
    ambiente_cozinha  = AmbienteGrupo.create(nome: 'cozinha',  ambiente: cozinha,  grupo: grupo_home)
    ambiente_jardim   = AmbienteGrupo.create(nome: 'jardim',   ambiente: sala,     grupo: grupo_casa)
    ambiente_corredor = AmbienteGrupo.create(nome: 'corredor', ambiente: banheiro, grupo: grupo_casa)
    ambiente_quarto   = AmbienteGrupo.create(nome: 'quarto',   ambiente: cozinha,  grupo: grupo_casa)
  end

  if ComponenteAmbiente.count.zero?
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_sala,     controle: controle1, identificador_componente: 'DVER_0E0FC1')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_banheiro, controle: controle1, identificador_componente: 'DVER_0E0FC2')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_cozinha,  controle: controle1, identificador_componente: 'DVER_0E0FC3')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_jardim,   controle: controle1, identificador_componente: 'DVER_0E0FC4')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_corredor, controle: controle1, identificador_componente: 'DVER_0E0FC5')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_quarto,   controle: controle1, identificador_componente: 'DVER_0E0FC6')
    ComponenteAmbiente.create(descricao: 'Lampada',         ambiente_grupo: ambiente_banheiro, controle: controle1, identificador_componente: 'DVER_0E0FC7')
    ComponenteAmbiente.create(descricao: 'Televisão',       ambiente_grupo: ambiente_sala,     controle: controle2, identificador_componente: 'DVES_0E0FC8')
    ComponenteAmbiente.create(descricao: 'Televisão',       ambiente_grupo: ambiente_quarto,   controle: controle2, identificador_componente: 'DVES_0E0FC9')
    ComponenteAmbiente.create(descricao: 'Ar Condicionado', ambiente_grupo: ambiente_sala,     controle: controle3, identificador_componente: 'DVES_0E0FC12')
    ComponenteAmbiente.create(descricao: 'Ar Condicionado', ambiente_grupo: ambiente_quarto,   controle: controle3, identificador_componente: 'DVES_0E0FC13')
    ComponenteAmbiente.create(descricao: 'Weather',         ambiente_grupo: ambiente_sala,     controle: controle1, identificador_componente: 'DVER_0E0FC10')
    ComponenteAmbiente.create(descricao: 'Weather',         ambiente_grupo: ambiente_quarto,   controle: controle1, identificador_componente: 'DVER_0E0FC11')
  end
end
