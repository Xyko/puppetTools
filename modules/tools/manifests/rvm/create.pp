define tools::rvm::create (
	$owner,
	$timeout=600,
	) {
	notice $owner

	exec {"$name":
	path    => "/bin:/sbin:/usr/bin:/usr/sbin",
	command => "bash -c 'curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	timeout => $timeout,
	}

	notice $timeout
}