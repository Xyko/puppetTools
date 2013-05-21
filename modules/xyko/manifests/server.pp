class xyko::server inherits xyko::common {

    tools::users::create { "xyko":
        usuario     => "xyko",
        grupo       => "xyko",
        uid         => "10000",
        gid         => "10000",
        password    => "fc4vbRND",
        home_dir  => "/home/xyko",
    }

}