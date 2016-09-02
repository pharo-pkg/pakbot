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
			ifTrue: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName ]
			ifFalse: [ error signal ] ]