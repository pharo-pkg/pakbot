testing
testGetUnknownPackage
	[ client 
		addPathSegment: 'foo';
		addPathSegment: 'latest';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound