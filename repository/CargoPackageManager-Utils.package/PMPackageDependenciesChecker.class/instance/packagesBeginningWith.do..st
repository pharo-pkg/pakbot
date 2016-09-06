updating
packagesBeginningWith: aListOfPrefix do: aBlock 
	(self imageDependencies associationsSelect: 
		[ :assoc | aListOfPrefix anySatisfy: [ :prefix | assoc key beginsWith: prefix ] ])
		associationsDo: [ :each | aBlock value: each ]