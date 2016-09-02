versions fetching
packages 
	^ znClient
		url: baseUrl;
		addPathSegment: 'packages';
		get