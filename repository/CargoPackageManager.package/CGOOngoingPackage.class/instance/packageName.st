accessing
packageName
	^ package 
		ifNil: [ 'N/A' ] 
		ifNotNil: [ package name ]