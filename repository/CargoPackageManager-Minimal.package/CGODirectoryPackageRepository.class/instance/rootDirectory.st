accessing
rootDirectory
	^ rootDirectory ifNil: [ rootDirectory := baseUrl pathPrintString asFileReference ]