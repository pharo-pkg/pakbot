updating
updateVersionWith: aString 
	aString ifNil: [ ^ self ].
	SemanticVersion fromString: aString. "Raise an error if the semantic version is not correct"
	self updateMethod: #version withContent: aString printString