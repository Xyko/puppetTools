class xyko::server inherits xyko::common {

	include tools::user

	file {
	"/etc/${projeto}.txt":
		ensure => file,
		source => "puppet:///modules/xyko/teste.txt";
	}

    # Usuário do projeto
    include supso::users
    Supso::Users::Create <| user == 'portal' |>

}