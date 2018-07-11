protocol
solveDependenciesOf: aDependency
	| resolvedPackage | 
	resolvedPackage := self resolvedPackageFor: aDependency.
				
	resolvedPackage resolvedProjectVersion dependencies 
		do: [ :dependency | self solveDependency: dependency ]