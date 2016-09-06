testing
testGetUnknownVersion
	[ client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '12.40.6';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound