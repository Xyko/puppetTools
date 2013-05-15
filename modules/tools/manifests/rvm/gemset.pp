define tools::rvm::gemset (		 
	$ruby,
	$gemset, ){
	notice $ruby
	notice $gemset

    case $name {
		'gem create': 	{ $command = "rvm ${ruby}@${gemset} --create" }
		'gem delete': 	{ $command = "rvm ruby-2.0.0-p195 && rvm  --force gemset delete rubyXyko" }
		 default:  		{ $command = "" }
    }

    notice $command

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "${command}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}