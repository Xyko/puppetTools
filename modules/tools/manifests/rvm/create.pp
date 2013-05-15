define tools::rvm::create (
	$owners,
	$timeout=600,
	) {
	notice $owners

	# exec {"$name":
	# path    => "/bin:/sbin:/usr/bin:/usr/sbin",
	# command => "bash -c 'su - ${owner} && curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	# timeout => $timeout,
	# }
}