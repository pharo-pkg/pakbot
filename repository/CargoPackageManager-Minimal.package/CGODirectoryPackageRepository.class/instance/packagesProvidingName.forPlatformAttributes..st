versions fetching
packagesProvidingName: aName forPlatformAttributes: platformAttributes
	| packages virtualPackageIndex |
	packages := OrderedCollection new.
	virtualPackageIndex := self virtualDirectory / aName asLowercase.
	^ virtualPackageIndex exists 
		ifFalse: [ #() ]
		ifTrue: [ virtualPackageIndex contents linesDo: [ :line | | pkgVersionRef pkgVersion |
				pkgVersionRef := line asPackageVersionReference.
				pkgVersion := (self fetch: pkgVersionRef packageName version: pkgVersionRef versionNumber).
				(platformAttributes includesAll: pkgVersion platformRequirements)
						ifTrue: [ packages add:  pkgVersion ] ].
				packages ]