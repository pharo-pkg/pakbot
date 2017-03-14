fetching
package: aPackageName
	[ ^ znClient
		url: baseUrl;
		addPathSegment: 'package';
		addPathSegment: aPackageName;
		get ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isNotFound 
			ifTrue: [ CGOPackageNotFoundError signal: aPackageName ]
			ifFalse: [ error signal ] ]