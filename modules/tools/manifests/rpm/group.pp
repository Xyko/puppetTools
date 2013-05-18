define tools::rpm::group($ensure = "present", $optional = false) {
   case $ensure {
      present,installed: {
         $pkg_types_arg = $optional ? {
            true => "--setopt=group_package_types=optional,default,mandatory",
            default => ""
         }
         exec { "Installing $name yum group":
            command => "yum -y groupinstall $pkg_types_arg --skip-broken '${name}'",
            #unless 	=> "yum -y groupinstall $pkg_types_arg --skip-broken $name",
            timeout => 600,
         }
      }
   }
}
