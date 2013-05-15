define tools::rvm::gem (		 
	$ruby,
	$gemset, ){

	case $name {
		'gemset create': 	{ $command = "rvm gemset create {gemset}" }
		'gemset delete': 	{ $command = "rvm --force gemset delete ${gemset}" }
		'gem   install': 	{ $command = "gem install mechanize" }
		 default:  		{ $command = "" }
	}

	exec {"rvm ${name}":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "gem install mechanize",
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