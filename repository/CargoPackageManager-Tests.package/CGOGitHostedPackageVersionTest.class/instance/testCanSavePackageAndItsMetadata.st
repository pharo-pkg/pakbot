tests
testCanSavePackageAndItsMetadata
	| sourcePackageVersion commit message |
	sourcePackageVersion := self cargoMinimalB9ee.
	sourcePackageVersion inspect.
	message := 'commit from test #testCanSavePackageAndItsMetadata'.
	commit := sourcePackageVersion 
		saveAndCommitWithMessage: message
		andMetadataString: 'CGOPackageUnit {
	#package : #Foo,
	#description : ''I\''m a dummy package used for testing purposes.'',
	#version : ''0.2.0-dev'',
	#timestamp : DateAndTime [ ''2016-12-19T14:54:41.55422+01:00'' ]'.
		
	self 
		assert: commit comment
		equals: message