define tools::rvm (
	$ruby='',
	$gemset='',
	$gem='' )	{

	case $name {
		'ruby install': 	{ $command = "install 	${ruby}" }
		'ruby uninstall': 	{ $command = "uninstall ${ruby}" }
		'ruby reinstall': 	{ $command = "reinstall ${ruby}" }
		'ruby remove': 		{ $command = "remove 	${ruby}" }
		'gemset create': 	{ $command = "rvm use ${ruby} && rvm gemset create ${gemset}" }
		'gemset delete': 	{ $command = "rvm use ${ruby} && rvm --force gemset delete ${gemset}" }
		'gem install': 		{ $command = "rvm use ${ruby} && gem install ${gem}" }
		'rvm create': 		{ $command = "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'" }
		'rvm delete': 		{ $command = "rvm implode" }		
		default:  			{ $command = "" }
	}

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "bash -lc ${command}",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}

}
