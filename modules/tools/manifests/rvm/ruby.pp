define tools::rvm::ruby (
	$ruby, )	{

    case $name {
		'ruby install': 	{ $command = "install" }
		'ruby uninstall': 	{ $command = "uninstall" }
		'ruby reinstall': 	{ $command = "reinstall" }
		'ruby remove': 		{ $command = "remove" }
		default:  { $command = "" }
    }

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm ${command} ${ruby}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


}
