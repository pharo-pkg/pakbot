versions fetching
packageNames
	^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		get