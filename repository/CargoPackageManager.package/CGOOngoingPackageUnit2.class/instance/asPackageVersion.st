converting
asPackageVersion
	| unit |
	unit := CGOPackageUnit new.
	CGOPackageUnit allInstVarNames
		reject: [ :name | #(authors contributors repositories) includes: name ]
		thenDo: [ :instVarName | 
			unit instVarNamed: instVarName put: (self instVarNamed: instVarName) ].
	^ unit	