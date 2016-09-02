accessing
platformAttributes
	^ PlatformAttributes ifNil: [ Smalltalk image metacelloPlatformAttributes ]