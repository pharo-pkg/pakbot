versions fetching
versionsOf: aPackageName
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName ]
			ifFalse: [ error signal ] ]