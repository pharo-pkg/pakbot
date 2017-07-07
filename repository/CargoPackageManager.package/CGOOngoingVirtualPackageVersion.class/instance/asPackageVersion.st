converting
asPackageVersion
	| virtual |
	virtual := CGOVirtualPackageVersion new.
	CGOVirtualPackageVersion allInstVarNames
		reject: [ :name | #(authors repositories) includes: name ]
		thenDo: [ :instVarName | 
			virtual instVarNamed: instVarName put: (self instVarNamed: instVarName) ].
	^ virtual	