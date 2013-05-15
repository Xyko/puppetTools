define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){
	notice $ruby
	notice $gemset

    case $name {
		'gem create': 	{ $command = "rvm use ${ruby}@${gemset} --create" }
		'gem delete': 	{ $command = "rvm ${ruby} do gemset delete ${gemset}" }
		 default:  		{ $command = "" }
    }

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "${command}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}