initialization - private
versionFrom: aDictionary
	| aString |
	aString := self mandatoryKey: #version from: aDictionary.
	^ aString asSemanticVersion