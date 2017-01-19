converting
sourcePackageVersionObject
	| dict |
	[ dict := self sourcePackageVersion ]
	on: MessageNotUnderstood "src metadata not present"
	do: [ ^ nil ].
	^ ((dict at: #backend) = #monticello)
		ifTrue: [ CGOMonticelloHostedPackageVersion 
			repositoryUrl: (dict at: #repositoryUrl)
			packageName: (dict at: #packageName ifAbsent: [ self packageName ]) 
			versionString: (dict at: #versionString) ]
		ifFalse: [ CGOGitHostedPackageVersion 
			repositoryUrl: (dict at: #repositoryUrl)
			subdirectory: (dict at: #subdirectory)
			packageName: (dict at: #packageName ifAbsent: [ self packageName ])
			commitish: (dict at: #commitish) ]