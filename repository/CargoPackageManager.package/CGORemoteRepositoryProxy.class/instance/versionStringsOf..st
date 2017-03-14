versions fetching
versionStringsOf: aPackageName
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]