define tools::rvm::rubyinstall {

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm",
		command 	=> "rvm install ${name}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


}