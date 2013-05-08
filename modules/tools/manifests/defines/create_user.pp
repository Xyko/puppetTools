define create_user(
    $usuario,
    $grupo      = false,
    $uid,
    $gid        = false,
    $home_dir   = true,
    $password   = false,
    $shell      = "/bin/bash",
    $grupos     = []
) {

    $nologin = "/sbin/nologin"
    $nohome  = "/"

    # Não podemos usar defines na mesma linha em que são definidos...
    $gidx   = $gid      ? { false => $uid, default => $gid }
    $grupox = $grupo    ? { false => $usuario, default => $grupo }
    $mypass = $password ? { false => "!!", default => $password }

    if ( $shell == false ) {
        $myshell = $nologin
        $myhome  = $home_dir ? { false => "/", true => "/home/$usuario", default => $home_dir }
        $mkhome  = $home_dir ? { false => false, default => true }
    }
    else {
        $myshell = $shell
        if ( $home_dir == false ) {
            # Sem home, com shell
            $myhome = $nohome
            $mkhome = false     # Se eu não tenho shell, por que criar um home???
        }
        else {
            # Com home, com shell
            $myhome = $home_dir ? { false => "/", true => "/home/$usuario", default => $home_dir }
            $mkhome = $home_dir ? { false => false, default => true }
        }
    }

    group { "${grupox}":
        ensure  => present,
        gid     => $gidx,
    }

    user { "${usuario}":
        ensure      => present,
        uid         => $uid,
        gid         => $gidx,
        home        => $myhome,
        managehome  => $mkhome,
        password    => $mypass,
        shell       => $myshell,
        groups      => $grupos,
        require     => Group[$grupox,$grupos],
    }

    ## COLOQUEI PQ SE O USUARIO NAO PODE SER AUTENTICAR ELE NAO PRECISA DAS CHAVES, NE ? (NAO TEM HOME DIR)
    if ( ( $shell != $nologin ) and ( $mkhome != false ) ) {
        file {"$myhome/.ssh":
            ensure  => directory,
            owner   => $usuario,
            group   => $grupox,
            mode    => "700",
            require => User["${usuario}"],
        }

        user_keys {"${usuario}_keys":
            usuario     => $usuario,
            home_dir    => $myhome,
            require     => File["$myhome/.ssh"],
        }
    }
}