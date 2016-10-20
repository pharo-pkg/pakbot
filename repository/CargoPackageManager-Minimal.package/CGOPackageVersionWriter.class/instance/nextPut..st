writing
nextPut: anObject
	anObject class = Association
		ifTrue: [ self writeAssociation: anObject ]
		ifFalse: [ anObject stonOn: self ]