converting
asPackageVersion
	| unit |
	unit := CGOPackageUnit new.
	CGOPackageUnit allInstVarNames
		do: [ :instVarName | 
			unit instVarNamed: instVarName put: (self instVarNamed: instVarName) ].
	^ unit	