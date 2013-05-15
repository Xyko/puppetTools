define tools::rvm::install (){

	# exec {"$name":
	# 	path    	=> "/bin:/sbin:/usr/bin:/usr/sbin",
	# 	command 	=> "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	# 	timeout 	=> 600,
	# 	logoutput	=> true,
	# 	user 		=> root,
	# }

    case $name {
		'rvm create': { $command = "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'" }
		'rvm delete': { $command = "rvm implode" }
		default:  { $command = "" }
    }

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "${command}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


}