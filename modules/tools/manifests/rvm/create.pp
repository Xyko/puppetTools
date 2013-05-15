define tools::rvm::create {

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin",
		command 	=> "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}