accessing
versionNumber
	^ version 
		ifEmpty: [ nil ]
		ifNotEmpty: [ version asSemanticVersion ]