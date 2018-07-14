Extension { #name : #IceLibgitRepository }

{ #category : #'*CargoPackageManager' }
IceLibgitRepository >> saveContent: aString inWorkingCopyFile: aRelativePathString [
	| outputFile |
	outputFile := self codeDirectory resolveString: aRelativePathString.
	outputFile writeStreamDo: 
		[ :stream |
		stream nextPutAll: aString ].
	self index addPath: (RelativePath with: aRelativePathString).
	^ outputFile
]
