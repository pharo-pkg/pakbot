ston
fromSton: stonReader
	| metacelloProject |
	
	metacelloProject := self basicNew.
	stonReader parseMapDo: [ :instVarName :value |
		(instVarName = 'baseline' or: [ instVarName = 'configuration' ])
		 	ifTrue: [ metacelloProject instVarNamed: 'name' put: value ]
		 	ifFalse: [ metacelloProject instVarNamed: instVarName put: value ] ].

	"ensure right types (e.g. url not string"
	^ metacelloProject 
		initializeWithName: metacelloProject name 
		repositoryUrl: metacelloProject repositoryUrl
		version: metacelloProject version