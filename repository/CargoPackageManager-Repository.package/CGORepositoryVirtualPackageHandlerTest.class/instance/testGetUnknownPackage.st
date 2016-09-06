testing
testGetUnknownPackage
	[ client 
		addPathSegment: 'foo';
		addPathSegment: '1.0.0';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound