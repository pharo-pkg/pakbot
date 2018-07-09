tests
testCanBeSerializedInSton
	| repositoryStonString |
	repository := self pharoCounterMasterCloned.
	repositoryStonString := STON toStringPretty: repository.
	
	self 
		assert: repositoryStonString
		equals: 'CGOGitRepository {
	#repositoryUrl : ''git://git@github.com/demarey/pharo-counter.git'',
	#version : ''master''
}'