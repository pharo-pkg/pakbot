protocol
solveDependenciesOf: aDependency
	| resolvedPackage | 
	
	resolvedPackage := self resolvedPackageFor: aDependency.
				
	resolvedPackage packageVersion dependencies 
		do: [ :dependency | self solveDependency: dependency ]