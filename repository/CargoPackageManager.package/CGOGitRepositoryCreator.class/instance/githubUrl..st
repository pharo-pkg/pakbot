setting
githubUrl: aStringOrUrl 
	url := aStringOrUrl asUrl.
	(self class isGitHubScheme: url) ifFalse: [ ^ self ].
	
	version := self commitishFrom: url.
	url := ('git+ssh://git@github.com/' , url host , (url pathPrintString copyUpToLast: $:) , '.git') asZnUrl