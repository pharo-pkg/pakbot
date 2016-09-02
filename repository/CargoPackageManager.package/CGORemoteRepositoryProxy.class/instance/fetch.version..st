versions fetching
fetch: aPackageName version: aVersion
	| pkgVersion |
	[ pkgVersion := znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageName;
		addPathSegment: aVersion asString;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageVersionNotFoundError signal: 'Cannot find ' , aPackageName, ' version: ', aVersion asString ]
			ifFalse: [ error signal ] ].
	self packageVersionCache saveDescription: pkgVersion.
	^ pkgVersion