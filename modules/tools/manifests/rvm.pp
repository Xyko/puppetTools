define tools::rvm (
	$ruby='',
	$gemset='',
	$gem='' )	{

	tools::out $name

	case $name {
		'ruby install': 	{ $command = "rvm install   ${ruby}" }
		'ruby uninstall': 	{ $command = "rvm uninstall ${ruby}" }
		'ruby reinstall': 	{ $command = "rvm reinstall ${ruby}" }
		'ruby remove': 		{ $command = "rvm remove 	${ruby}" }
		'gemset create': 	{ $command = "rvm use ${ruby} && rvm gemset create ${gemset}" }
		'gemset delete': 	{ $command = "rvm use ${ruby} && rvm --force gemset delete ${gemset}" }
		'gem install': 		{ $command = "rvm use ${ruby} && gem install ${gem}" }
		'rvm create': 		{ 
			notice "O RVM já está instalado."
			#$command = "curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby" 
		}
		'rvm delete': 		{ $command = "rvm implode" }		
		default:  			{ $command = "" }
	}

	tools::out $command

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "bash -lc '${command}'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


#sudo -i puppet apply -e "exec {teste: path  => \"/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin\", command => \"bash -lc 'rvm implode'\", timeout => 600, logoutput=> true, user => root, }"


}
