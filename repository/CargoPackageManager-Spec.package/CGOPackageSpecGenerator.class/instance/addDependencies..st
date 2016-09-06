as yet unclassified
addDependencies: packagesName
	| methodText |
	
	methodText := 'dependencies
'.
	packagesName do: [ :packageName |
		methodText := methodText ,
			'	(package addDependency: ''' , packageName , ''')
' ,
			'		addFixedVersionConstraint: '''';
		yourself.
' ].
	class compile: methodText.