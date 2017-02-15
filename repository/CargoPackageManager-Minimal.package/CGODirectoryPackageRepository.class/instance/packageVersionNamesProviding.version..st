private
packageVersionNamesProviding: aVirtualPackageName version: aSemanticVersion
	| packages virtualPackageVersionIndex |
	packages := OrderedCollection new.
	virtualPackageVersionIndex := self virtualIndexesDirectory / aVirtualPackageName asLowercase / (aVirtualPackageName asLowercase , '@' , aSemanticVersion asString).
	^ virtualPackageVersionIndex exists 
		ifFalse: [ #() ]
		ifTrue: [ virtualPackageVersionIndex contents lines ]