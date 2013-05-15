define tools::rvm::create (
	owner,
	$timeout
	$timeout=600,
	) {
	notice $owner

	exec {"$name execute":
	path    => "/bin:/sbin:/usr/bin:/usr/sbin",
	command => "sudo bash -c 'cd ~ && curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	timeout => $timeout,
	}
}