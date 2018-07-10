utils
installProject

	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '2.0';
		load.
