define tools::rvm::rubyinstall {

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm install ${name}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


}