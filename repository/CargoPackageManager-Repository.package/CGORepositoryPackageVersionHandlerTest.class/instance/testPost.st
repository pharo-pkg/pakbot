tests-public
testPost
	| packageVersion |

	client
		addPathSegment: 'Bar';
		addPathSegment: '3.0.0';
		entity: ((ZnEntity text: self bar300Ston)
					contentType: ZnMimeType applicationSton);
		post;
		yourself.
	self assert: client isSuccess.
	
	client get.
	self assert: client isSuccess.
	packageVersion := client contents.
	self assert: (packageVersion isKindOf: CGOPackageVersion).
	self assert: packageVersion asString equals: 'Bar@3.0.0'.
	
	"clean up"
	packageVersion remove