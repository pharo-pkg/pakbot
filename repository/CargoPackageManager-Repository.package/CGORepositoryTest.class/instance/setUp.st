running
setUp
	| delegate |
	delegate := CGORepositoryRestServerDelegate newWith: CGOTestPackageRepository new.
	server := ZnServer startOn: 1800 + 10 atRandom.
	server 
		delegate: delegate;
		debugMode: true;
		yourself.
	
	client := ZnClient new
		url: server localUrl;
		accept: ZnMimeType applicationSton;
		enforceHttpSuccess: true;
		contentReader: [ :entity | entity ifNotNil: [ STON fromString: entity contents ] ];
		contentWriter: [ :object | ZnEntity with: (CGOPackageVersionWriter toStringPretty: object) type: ZnMimeType applicationSton ];
		yourself