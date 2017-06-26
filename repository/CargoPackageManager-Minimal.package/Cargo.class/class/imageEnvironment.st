accessing
imageEnvironment
	^ PlatformAttributes ifNil: [ Smalltalk image metacelloPlatformAttributes ]