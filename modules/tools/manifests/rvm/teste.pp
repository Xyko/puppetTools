define tools::rvm::teste (){


	exec {"rvm ${name}":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		refreshonly	=> true,
		command 	=> "bash -c 'rvm use ruby-1.9.3-p429'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}



}