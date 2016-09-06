starting
startWebServer
	| delegate |
	delegate := CGORepositoryRestServerDelegate newWith: repository.
	server := ZnServer startOn: 8080.
	server 
		delegate: delegate;
		debugMode: true;
		yourself.