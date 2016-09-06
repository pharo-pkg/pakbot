testing
testGetUnknownPackage
	[ client 
		addPathSegment: 'foo';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound