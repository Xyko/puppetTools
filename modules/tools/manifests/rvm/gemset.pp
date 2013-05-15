define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){

	case $name {
		'gem create': 	{ $command = "rvm gemset create {gemset}" }
		'gem delete': 	{ $command = "rvm --force gemset delete ${gemset}" }
		 default:  		{ $command = "" }
	}

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm ${ruby}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "${command}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}