updating
updateVersion
	| version |
	version := UIManager default 
		request: 'Package version:'
		initialAnswer: self version.
	self updateVersionWith: version.