testing
testGetUnknownVersion
	[ client 
		addPathSegment: 'Grease-Core';
		addPathSegment: '12.40.6';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound