#
# Este define não deve ser chamado pelo desenvolvedor final, é para uso
# exclusivo de supso::users
#
# Seu objetivo é varrer todos os projetos e fazer as declarações virtuais dos
# usuários necessários, segundo os hashs de definição
#
define tools::users::declare {

  include stdlib
  include tools::users::params

  $user   = $name

  $myuser = $tools::users::params::map[$user]

  $uid          = $myuser[uid]    # Obrigatório
  $gid          = $myuser[gid]    # Pode ser undef e trata disso em supso::user::declare
  $group        = $myuser[group]  # Pode ser undef e trata disso em supso::user::declare
  $_shell       = $myuser[shell]  # Pode ser undef, neste caso supso::user::declare usa /bin/bash
  $_home        = $myuser[home]   # Pode ser undef e trata disso em supso::user::declare
  $bashrc       = $myuser[bashrc] # Pode ser undef e trata disso em supso::user::declare
  $groups       = $myuser[groups] # Pode ser undef e trata disso em supso::user::declare
  $allowdupe    = $myuser[allowdupe]  # Pode ser undef e trata disso em supso::user::declare
  $_system      = $myuser[system] # Se for undef vai setar explicitamente para false
  $_usepma      = $myuser[usepma] # Se for undef vai setar explicitamente para false
  $_userundeck  = $myuser[userundeck] # Se for undef vai setar explicitamente para false

  if ($_home == 'false') {
    # Há um bug no Puppet 2.7.x e estamos usando 'false' (string) ao invés de boolean,
    # porque ao pegar o valor de uma chave com false (boolean) no hash ele traz undef
    # ao invés de false
    $home = false
    @infra::notify {
      "Tratando bug do hash com false para home em supso::users::declare(${user})":
        selector => "tools::users=${user}",
        ;
    }
  } else {
    $home = $_home
  }

  if ($_shell == 'false') {
    # Há um bug no Puppet 2.7.x e estamos usando 'false' (string) ao invés de boolean,
    # porque ao pegar o valor de uma chave com false (boolean) no hash ele traz undef
    # ao invés de false
    $shell = false
    @infra::notify {
      "Tratando bug do hash com false para shell em supso::users::declare(${user})":
        selector => "tools::users=${user}",
        ;
    }
  } else {
    $shell = $_shell
  }

  if ($_system == undef) {
    # Precisa dar um valor explícito para que o filtro funcione na
    # hora de realizar com um Collector
    $system = false
  } else {
    $system = $_system
  }

  if ($_usepma == undef) {
    # Precisa dar um valor explícito para que o filtro funcione na
    # hora de realizar com um Collector
    $usepma = false
  } else {
    $usepma = $_usepma
  }

  if ($_userundeck == undef) {
    # Precisa dar um valor explícito para que o filtro funcione
    $userundeck = false
  } else {
    $userundeck = $_userundeck
  }

  case $::zone {
    'staging', 'prod': {
      $_pass = $myuser[pass_prod] # Pode ser undef e trata disso em supso::user::create
      if ($_pass == 'false') {
        $pass = false             # Mesmo bug do false
        @infra::notify {
          "Tratando bug do hash com false para pass_prod em supso::users::declare(${user})":
            selector => "tools::users=${user}",
            ;
        }
      } else {
        # Caso especial: usuario puppet nas máquinas de One Click Deploy em prod
        # _não_ pode ter a mesma senha pré-fixada -- Carolo
        if ($user == 'puppet' and $::keep_puppet_password == '1') {
          $pass = undef
        } else {
          $pass = $_pass
        }
      }
    }
    default: {
      $_pass = $myuser[pass_dev]
      if ($_pass == undef) {
        $prefix = '$1$'
        $rand   = md5($::fqdn)
        $salt   = "${prefix}${rand}"
        $pass   = inline_template('<%= user.crypt(salt) %>')
      } elsif ($_pass == 'false') {
        $pass = false             # Mesmo bug do false
        @infra::notify {
          "Tratando bug do hash com false para pass_dev em supso::users::declare(${user})":
            selector => "tools::users=${user}",
            ;
        }
      } else {
        $pass = $_pass
      }
    }
  }

  @tools::users::create { $user:
    user        => $user,
    uid         => $uid,
    group       => $group,
    gid         => $gid,
    shell       => $shell,
    home        => $home,
    bashrc      => $bashrc,
    pass        => $pass,
    groups      => $groups,
    allowdupe   => $allowdupe,
    system      => $system,
    usepma      => $usepma,
    userundeck  => $userundeck,
  }
}

# EOF
