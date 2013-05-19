define tools::rpm::yum($packlist,$version='') {

	notice $packlist

	foreach $packname in $packlist {
		notice $packname
	}

}