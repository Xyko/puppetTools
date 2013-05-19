define tools::rpm::yum($packlist,$version='') {

	notice $packlist

	foreach $packname $packlist {
		notice $packname
	}

}