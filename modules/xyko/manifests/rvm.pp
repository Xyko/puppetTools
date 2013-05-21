define xyko::rvm (
	$ruby='',
	$gemset='',
	$gem='' )	{

	case $name {
		'ruby install': 	{ $command = "rvm install   ${ruby}" }
		'ruby uninstall': 	{ $command = "rvm uninstall ${ruby}" }
		'ruby reinstall': 	{ $command = "rvm reinstall ${ruby}" }
		'ruby remove': 		{ $command = "rvm remove 	${ruby}" }
		'gemset create': 	{ $command = "rvm use ${ruby} && rvm gemset create ${gemset}" }
		'gemset delete': 	{ $command = "rvm use ${ruby} && rvm --force gemset delete ${gemset}" }
		'gem install': 		{ 
			if $gemset == '' {
				$command = "rvm use ${ruby} && gem install ${gem}" 
			} else {
				$command = "rvm use ${ruby}@${gemset} && gem install ${gem}" 
			}
		}
		'rvm create': 		{ 
			if exists("/usr/local/rvm") {
				$command = "curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby"
			} else {
				debug_msg("alert", "O RVM já está instalado.")
				$command = ""
			}
		}
		'rvm delete': 		{ $command = "rvm implode" }
		default:  			{ $command = "" }
	}

	exec {"$name":
		path    	=> "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin",
		command 	=> "bash -lc '${command}'",
		timeout 	=> 600,
		logoutput	=> true,
		user 		=> root,
	}


#sudo -i puppet apply -e "exec {teste: path  => \"/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/rvm/bin\", command => \"bash -lc 'rvm implode'\", timeout => 600, logoutput=> true, user => root, }"


}
