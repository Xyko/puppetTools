define tools::rvm::rubyinstall {


	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin",
		command 	=> "bash -c 'rvm install $(name)'",
		timeout 	=> $timeout,
		logoutput	=> true,
		user 		=> root,
	}


}