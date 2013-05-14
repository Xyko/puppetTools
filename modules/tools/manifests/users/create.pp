# Define: tools::users::create
#
# Meta define usado para criar usuários para serem usados em puppet realize
#
# Deve ser usado para criar usuários necessários a cada projeto. Para mais
# informações, veja supso/users/params.pp
#
# Exemplos:
#  include tools::users
#  Tools::Users::Create <| user == 'portal' |>
#

#
# Author: Gustavo Soares Souza / Rogério Carvalho Schneider / Jefferson Braga
# Adaptado para novo modelo por: Fernando Carolo, Jonny
#
# Parâmetros:
#
# - uid:        uid para este usuário (obrigatório)
#
# - group:      nome de grupo para este usuário, por default é igual ao username
#
# - gid:        gid para este usuário, se não definido fica igual ao uid
#
# - shell:      login shell, se não definido será /bin/bash onde o usuário puder logar,
#               se chamado com false usa /sbin/nologin
#
# - home:       home dir, se não definido será /home/${username}, use 'false' (string)
#               para não criar, graças a um bug do Puppet 2.7.x
#
# - bashrc:     conteúdo do bashrc (para ser usado com template), use undef (default) para não modificar
#               Obs: Evite usar este parâmetro.  O que for necessário colocar aqui provavelmente
#               ficaria melhor em outro lugar (scripts do projeto).
#
# - pass_dev:   senha criptografada para os ambientes vagrant, dev, qa, qa1 e qa2, se não for
#               especificada, usa o próprio username; use 'false' (string) para manter bloqueado
#
# - pass_prod:  senha criptografada para os ambientes staging e prod, se não for especificada
#               não altera a senha existente, o que significa uma senha desabilitada para
#               usuários novos criados pelo puppet-setup; use 'false' (string) para manter bloqueado
#
# - groups:     lista de grupos adicionais para o usuário (opcional)
#
# - allowdupe:  permite a criação de usuários e grupos com uids e/ou gids duplicados; use apenas
#               para manter a compatibilidade com o legado
#
# - system:     indica que é um usuário de sistema, ou seja, não está associado a
#               nenhuma aplicação do portal, sendo false por defaut; usado para evitar
#               a criação deste usuário em máquinas compartilhadas, como estáticos e filer,
#               além de não instalar as chaves padrão de acesso para estes usuários
#
# - usepma:     indica que é um usuário de alguma aplicação que ainda usa o sistema de PMA
#               para deploy, por isso precisa das chaves públicas desse sistema
#
# - userundeck: indica que é um usuário uma aplicação que ainda usa o sistema de PMA
#               para deploy, por isso precisa das chaves públicas desse sistema
#
# Actions:
#   - Declara User e Group conforme especificado
#
# Requires:
#   -

define tools::users::create (
    $user,
    $uid,
    $group      = $user,
    $gid        = $uid,
    $shell      = '/bin/bash',
    $home       = undef,
    $bashrc     = undef,
    $pass       = undef,
    $groups     = [],
    $allowdupe  = false,
    $system     = false,
    $usepma     = false,
    $userundeck = false,
) {

  $nologin      = '/sbin/nologin'
  $nohome       = '/'
  $blocked_pass = '!!'

  $mypass       = $pass ? { false => $blocked_pass, default => $pass }

  # Realiza as mensagens que foram pré-geradas em supso::users::declare
  Infra::Notify <| $selector == "supso::users=${user}" |>

  # Sem shell
  if ( $shell == false ) {
      $myshell  = $nologin
      $myhome   = $home ? { false => $nohome, undef => "/home/${user}", default => $home }
      $mkhome   = $home ? { false => false,   default => true }
  } else {
    $myshell  = $shell
    if ( $home == false ) {
      # Sem home, com shell
      $myhome = $nohome
      $mkhome = false     # Se eu não tenho shell, por que criar um home???
    } else {
      # Com home, com shell
      $myhome = $home ? { undef => "/home/${user}", default => $home }
      $mkhome = true
    }
  }

  # Hora de cuidar das dependências, ou seja, criar os usuários que darão
  # origem aos grupos listados em $groups

  realize Tools::Users::Create [ $groups ]

  group { $group:
    ensure      => present,
    gid         => $gid,
    allowdupe   => $allowdupe,
  }

  user { $user:
    ensure      => present,
    uid         => $uid,
    gid         => $gid,
    home        => $myhome,
    managehome  => $mkhome,
    password    => $mypass,
    shell       => $myshell,
    groups      => $groups,
    allowdupe   => $allowdupe,
    require     => Group[ $group, $groups ],
  }

  # Quem tem shell e home directory pode se autenticar com as chaves padrão
  if ( ( $shell != $nologin ) and ( $mkhome != false ) and ( $system == false ) ) {

    if ( $bashrc != undef ) {
      file { "${myhome}/.bashrc":
        ensure  => file,
        owner   => $uid,
        group   => $gid,
        mode    => '0644',
        content => $bashrc,
        require => User[$user],
      }
    }
    file { "${myhome}/.ssh":
      ensure  => directory,
      owner   => $uid,
      group   => $gid,
      mode    => '0700',
      require => User[$user],
    }
  }
}

# EOF
