define tools::rvm::install (){

	# exec {"$name":
	# 	path    	=> "/bin:/sbin:/usr/bin:/usr/sbin",
	# 	command 	=> "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	# 	timeout 	=> 600,
	# 	logoutput	=> true,
	# 	user 		=> root,
	# }

    case $name {
		'create': { $command = "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'" }
		'delete': { $command = "rm -rf /usr/local/rvm && rm /etc/profile.d/rvm.sh" }
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