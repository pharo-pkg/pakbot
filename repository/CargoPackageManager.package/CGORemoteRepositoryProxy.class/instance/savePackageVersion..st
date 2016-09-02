versions posting
savePackageVersion: aPackageVersion
	[ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		addPathSegment: aPackageVersion packageName asString;
		addPathSegment: aPackageVersion version asString;
		entity: ( (ZnEntity text: (CGOPackageVersionWriter toStringPretty: aPackageVersion))
						contentType: ZnMimeType applicationSton );
		post ]
	on: ZnHttpUnsuccessful 
	do: [ :error |
		znClient isBadRequest 
			ifTrue: [ CGOPackageVersionAlreadyExistsError signal: 'Package ' , aPackageVersion asString, ' already exists!' ]
			ifFalse: [ Error signal: error messageText ] ]