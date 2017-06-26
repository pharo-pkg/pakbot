versions fetching
packagesProviding: aName version: aSemanticVersion forEnvironment: environment
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'virtualpackages';
		addPathSegment: aName;
		addPathSegment: aSemanticVersion asString;
		queryAt: #platform put: ($, join: environment);
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageVersionNotFoundError 
						signal: 'Cannot find virtual package ' , aName , ' in version: ' , aSemanticVersion asString , ' for: ' environment ]
			ifFalse: [ error signal ] ]