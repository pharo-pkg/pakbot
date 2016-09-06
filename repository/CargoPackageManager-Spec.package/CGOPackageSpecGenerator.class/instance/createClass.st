as yet unclassified
createClass
	| className |
	className := (self normalizedPackageName: package) , 'Spec'.
	class := CGOPackageSpec
		subclass: className asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'PackagesManager-SeasideDescription'.