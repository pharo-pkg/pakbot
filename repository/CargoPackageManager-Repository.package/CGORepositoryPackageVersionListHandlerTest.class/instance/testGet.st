testing
testGet
	| response |

	client
		addPathSegment: 'Grease-Core';
		get;
		yourself.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #( '1.0.0' '1.1.5' '2.0.0')