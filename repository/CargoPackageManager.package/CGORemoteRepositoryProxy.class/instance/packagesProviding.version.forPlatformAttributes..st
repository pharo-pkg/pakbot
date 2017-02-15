versions fetching
packagesProviding: aName version: aSemanticVersion forPlatformAttributes: platformAttributes
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'virtualpackages';
		addPathSegment: aName;
		addPathSegment: aSemanticVersion asString;
		queryAt: #platform put: ($, join: platformAttributes);
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageVersionNotFoundError 
						signal: 'Cannot find virtual package ' , aName , ' in version: ' , aSemanticVersion asString , ' for: ' platformAttributes ]
			ifFalse: [ error signal ] ]