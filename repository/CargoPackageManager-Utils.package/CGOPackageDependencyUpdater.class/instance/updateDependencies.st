updating
updateDependencies
	manifests do: [ :manifest | self updateDependenciesOf: manifest ]