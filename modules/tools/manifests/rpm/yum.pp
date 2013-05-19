define tools::rpm::yum($packlist,$version='lasted') {

	package { $packlist:
	   ensure 	=> installed,
	}

}