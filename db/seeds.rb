unless Rails.env.test?
  if Admin.count.zero?
    Admin.create(email:'admin@admin.com', password:'administrador')
  end
  if Usuario.count.zero?
    usuario = Usuario.create(email:'usuario@usuario.com', password:'usuario', admin: 'true')
    usuario.confirm
  end
  if Grupo.count.zero?
    grupo1 = Grupo.create(nome:'Casa do Usuário')
    grupo2 = Grupo.create(nome:'Escritório do Usuário')
  end
  if GrupoUsuario.count.zero?
    GrupoUsuario.create(usuario:usuario, grupo:grupo1)
    GrupoUsuario.create(usuario:usuario, grupo:grupo2)
  end
  if Ambiente.count.zero?
    ambiente1 = Ambiente.create(nome:'Sala', grupo:grupo1)
    ambiente2 = Ambiente.create(nome:'Cozinha', grupo:grupo1)
    ambiente3 = Ambiente.create(nome:'Banheiro', grupo:grupo2)
    ambiente4 = Ambiente.create(nome:'Sala Principal', grupo:grupo2)
  end
  if ControleComponente.count.zero?
    controle1 = ControleComponente.create(descricao:'Nenhum')
    controle2 = ControleComponente.create(descricao:'Televisao')
    controle3 = ControleComponente.create(descricao:'Ar Condicionado')
  end
  if Componente.count.zero?
    Componente.create(descricao:'Luz de centro', ambiente:ambiente1, controle_componente:controle1)
    Componente.create(descricao:'Televisão', ambiente:ambiente1, controle_componente:controle2)
    Componente.create(descricao:'Luz da mesa', ambiente:ambiente2, controle_componente:controle1)
    Componente.create(descricao:'Geladeira', ambiente:ambiente2, controle_componente:controle1)
    Componente.create(descricao:'Luz', ambiente:ambiente3, controle_componente:controle1)
    Componente.create(descricao:'Chuveiro', ambiente:ambiente3, controle_componente:controle1)
    Componente.create(descricao:'Ar Condicionado', ambiente:ambiente4, controle_componente:controle3)
    Componente.create(descricao:'Luz de entrada', ambiente:ambiente4, controle_componente:controle1)
  end
end
