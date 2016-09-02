versions fetching
packagesProviding: aName for: platformAttributes
	| packages virtualPackageIndex |
	packages := OrderedCollection new.
	virtualPackageIndex := self virtualDirectory / aName asLowercase.
	^ virtualPackageIndex exists 
		ifFalse: [ #() ]
		ifTrue: [ virtualPackageIndex contents linesDo: [ :line | | pkgVersionRef pkgVersion |
				pkgVersionRef := line asPackageVersionReference.
				pkgVersion := (self fetch: pkgVersionRef packageName version: pkgVersionRef versionNumber).
				platformAttributes
					ifEmpty: [  packages add:  pkgVersion ]
					ifNotEmpty: [ (pkgVersion platformRequirements difference: platformAttributes)
						ifEmpty: [ packages add:  pkgVersion ] ] ].
				packages ]