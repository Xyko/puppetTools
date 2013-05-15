define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){
	notice $ruby
	notice $gemset

    case $name {
		'gem create': 	{ $command = "use ${ruby}@${gemset} --create" }
		'gem delete': 	{ $command = "rvm ${ruby} do gemset delete ${gemset}" }
		 default:  		{ $command = "" }
    }

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "rvm use ruby-2.0.0-p195 && rvm gemset create ${gemset}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}