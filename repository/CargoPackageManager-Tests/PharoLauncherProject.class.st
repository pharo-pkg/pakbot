"
Builder of Cargo metadata for the PharoLauncher project.

	self buildAndRegisterIn: PBPackageRegistry default.
	
	self buildWithoutPackageDependencyAndRegisterIn: PBPackageRegistry default.
	
	self new 
		buildProject;
		buildExternalProjectDependencies.
"
Class {
	#name : #PharoLauncherProject,
	#superclass : #Object,
	#instVars : [
		'registry',
		'project'
	],
	#category : #'CargoPackageManager-Tests-LauncherRessource'
}

{ #category : #'instance creation' }
PharoLauncherProject class >> buildAndRegisterIn: aCGOPackageRegistry [
	^ self new buildAndRegisterIn: aCGOPackageRegistry
]

{ #category : #'instance creation' }
PharoLauncherProject class >> buildAndRegisterInDefault [

	self buildAndRegisterIn: PBPackageRegistry default

]

{ #category : #'instance creation' }
PharoLauncherProject class >> buildWithoutPackageDependencyAndRegisterIn: aCGOPackageRegistry [
	^ self new buildWithoutPackageDependencyAndRegisterIn: aCGOPackageRegistry
]

{ #category : #'instance creation' }
PharoLauncherProject >> buildAndRegisterIn: aCGOPackageRegistry [
	registry := aCGOPackageRegistry.
	self
		buildProject;
		buildExternalProjectDependencies;
		buildPackages.
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildExternalProjectDependencies [
	project addDependency: 
		(PBMetacelloBaselineProjectDependency  
			name: 'OSSubprocess'
			repositoryUrl: 'https://github.com/pharo-contributions/OSSubprocess.git'
			version: 'v1.2.1').
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'OSWinSubprocess'
			repositoryUrl: 'https://github.com/pharo-contributions/OSWinSubprocess.git'
			version: 'v1').
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'XMLParser'
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildPackages [
	(project newNotLoadedPackage: #'PharoLauncher-Core')
		description: 'Core package with the model, commands and settings.';
		addDependencyOn: #'XMLParser::Core';
		addDependencyOn: #'OSSubprocess';
		addDependencyOn: #'OSWinSubprocess';
		addDependencyOn: #'PharoLauncher-80Compatibility';
		addDependencyOn: #'PharoLauncher-Pharo9ToRemove-FileLocator'.
	(project newNotLoadedPackage: #'PharoLauncher-Spec2')
		description: 'PharoLauncher UI done in Spec 2.';
		addDependencyOn: #'PharoLauncher-Core'. "Spec2 already loaded in P9"
	(project newNotLoadedPackage: #'PharoLauncher-80Compatibility')
		description: 'extensions needed for Pharo 8'.
	(project newNotLoadedPackage: #'PharoLauncher-Pharo9ToRemove-FileLocator')
		description: 'File locator extension integrated into Pharo 9'.

	(project newNotLoadedPackage: #'PharoLauncher-Tests-Core')
		description: 'Tests of the PharoLauncher-Core package.';
		addDependencyOn: #'PharoLauncher-Spec2'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Commands')
		description: 'Tests of PharoLauncher commands.';
		addDependencyOn: #'PharoLauncher-Spec2'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-SpecUI')
		description: 'Tests of the PharoLauncher UI.';
		addDependencyOn: #'PharoLauncher-Core';
		addDependencyOn: #'PharoLauncher-Spec2'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Download')
		description: 'Tests of the PharoLauncher-Download package.';
		addDependencyOn: #'PharoLauncher-Core'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Functional')
		description: 'Tests of the PharoLauncher-Download package.';
		addDependencyOn: #'PharoLauncher-Core';
		addDependencyOn: #'PharoLauncher-Tests-Download'.
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildProject [
	project := (PBProject named: #PharoLauncher)
		description:
			'Pharo Launcher is a cross-platform application that

    lets you manage your Pharo images (launch, rename, copy and delete);
    lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);
    lets you create new images from any template,
    automatically find and download the appropriate VM to launch your images.';
		repository: "self buildRepository" PBNoRepository new;
		registry: self registry;
		yourself.
		
	registry register: project.
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildRepository [
	 project repository: self repository.
	^ project
]

{ #category : #'instance creation' }
PharoLauncherProject >> buildWithoutPackageDependencyAndRegisterIn: aCGOPackageRegistry [
	registry := aCGOPackageRegistry.
	self
		buildProject;
		buildExternalProjectDependencies;
		buildPackages;
		removePackagesDependencies.
	^ project
]

{ #category : #accessing }
PharoLauncherProject >> registry [ 
	^ registry ifNil: [ registry := PBPackageRegistry new ]
]

{ #category : #building }
PharoLauncherProject >> removePackagesDependencies [
	project packageUnits do: [ :unit |
		unit dependencies: OrderedCollection new ].
	^ project
]

{ #category : #building }
PharoLauncherProject >> repository [
	^ PBGitRepositoryCreator new
			url: 'https://github.com/pharo-project/pharo-launcher.git';
			version: 'dev';
			subdirectory: 'src';
			create
]
