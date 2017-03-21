versions fetching
latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		addPathSegment: 'latest';
		queryAt: #platform put: ($, join: platformAttributes);
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]