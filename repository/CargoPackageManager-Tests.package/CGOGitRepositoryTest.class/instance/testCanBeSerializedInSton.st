tests
testCanBeSerializedInSton
	| repository repositoryStonString |
	repository := self pharoCounterMaster.
	repositoryStonString := STON toStringPretty: repository.
	
	self 
		assert: repositoryStonString
		equals: 'CGOGitRepository {
	#repositoryUrl : ''git+ssh://git@github.com/demarey/pharo-counter.git'',
	#version : ''master''
}'