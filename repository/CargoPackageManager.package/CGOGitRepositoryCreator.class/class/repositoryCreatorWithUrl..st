action
repositoryCreatorWithUrl: urlOrString
	| url |
	url := self urlWithScheme: urlOrString.
	^ (self isGitHubScheme: url)
		ifTrue: [ self new 
						githubUrl: url;
						yourself ]
		ifFalse: [ self new
						url: url;
						yourself ]