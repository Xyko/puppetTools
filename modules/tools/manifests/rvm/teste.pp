define tools::rvm::teste (){


	exec {"rvm ${name}":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "bash -c 'rvm use ruby-1.9.3-p429 && rvm list'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}



}