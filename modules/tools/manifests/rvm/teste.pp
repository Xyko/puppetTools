define tools::rvm::teste (){

	

	exec {"rvm ${name}":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "gem list",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}



}