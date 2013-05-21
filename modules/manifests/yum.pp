define xyko::yum($packlist,$version='lasted') {

	package { $packlist:
	   ensure 	=> installed,
	}

}