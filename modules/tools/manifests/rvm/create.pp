define tools::rvm::create (
	$xyko,
	$timeout=600,
	) {
	notice $xyko

	# exec {"$name":
	# path    => "/bin:/sbin:/usr/bin:/usr/sbin",
	# command => "bash -c 'su - ${owner} && curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby'",
	# timeout => $timeout,
	# }
}