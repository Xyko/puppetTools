define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){
	notice $ruby
	notice $gemset

    case $name {
		'create': 		{ $command = "use ${ruby}@${gemset} --create" }
		'delete': 		{ $command = "rvm ${ruby} do gemset delete ${gemset}" }
		default:  		{ $command = "" }
    }

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm ${command} ${ruby}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}