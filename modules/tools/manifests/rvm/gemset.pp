define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){

	case $name {
		'gemset create': 	{ $command = "rvm gemset create {gemset}" }
		'gemset delete': 	{ $command = "rvm --force gemset delete ${gemset}" }
		 default:  		{ $command = "" }
	}

	exec {"rvm ${name}":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm use ruby-2.0.0-p195",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

	# exec {"$name":
	# 	path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
	# 	command 	=> "bash -c '${command}'",
	# 	timeout 	=> 600,
	# 	logoutput	=> true,
	# 	user 		=> root,
	# }

}