define tools::rvm::rubyinstall {


	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm",
		command 	=> "bash -c 'rvm install ${name}'",
		timeout 	=> $timeout,
		logoutput	=> true,
		user 		=> root,
	}


}