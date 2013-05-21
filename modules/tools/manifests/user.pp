define tools::user(
    $usuario,
    $grupo      = false,
    $uid,
    $gid        = false,
    $home_dir   = true,
    $password   = false,
    $shell      = "/bin/bash",
    $grupos     = []
) {

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

}
