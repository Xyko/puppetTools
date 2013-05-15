define tools::rvm::gem (		 
	$ruby,
	$gemset,
	$gem='',
	$version='', ){

	case $name {
		'gemset create': 	{ $command = "rvm use ${ruby} && rvm gemset create {gemset}" }
		'gemset delete': 	{ $command = "rvm use ${ruby} && rvm --force gemset delete ${gemset}" }
		'gem   install': 	{ $command = "rvm use ${ruby} && gem install ${gem}" }
		 default:  		{ $command = "" }
	}

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "bash -lc '${command}'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}