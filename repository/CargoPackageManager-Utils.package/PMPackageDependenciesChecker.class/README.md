Utility class to easily compute dependencies of an image and generate associated metadata.

DAPackageDependenciesChecker new inspect.

examples:

self sortedTopGroupsWithAtLeast: 3.
self updateDependenciesOf: #Kernel.
self 
	packagesBeginningWith: #(#Kernel #Collection) 
	do: [ :each | self updateDependenciesOf: each key ]