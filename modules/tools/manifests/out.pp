define tools::out ($msg='') {

	$red="\\033[01;31m"
	$redalarm="\\033[05;31m"
	$normal="\\033[00;37m"

	notice "${red}${msg}${normal}"

}