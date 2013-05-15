define tools::rvm::ruby (
	$ruby, )	{

    case $name {
		'install': 		{ $command = "install" }
		'uninstall': 	{ $command = "uninstall" }
		'reinstall': 	{ $command = "reinstall" }
		'remove': 		{ $command = "remove" }
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
