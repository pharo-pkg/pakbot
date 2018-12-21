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
		(PBMetacelloConfigurationProjectDependency
			name: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'XMLParser'
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildPackages [
	(project newNotLoadedPackage: #'PharoLauncher-Download')
		description: 'Package dealing with image / VM detection and download.';
		addDependencyOn: #'OSProcess::Core with Output';
		addDependencyOn: #'ProcessWrapper::Core'.
	(project newNotLoadedPackage: #'PharoLauncher-Core')
		description: 'Core package with the model, commands and settings.';
		addDependencyOn: #'PharoLauncher-Download';
		addDependencyOn: #'XMLParser::Core';
		addDependencyOn: #'Ston';
		addDependencyOn: #'JSON'.
	(project newNotLoadedPackage: #'PharoLauncher-Spec')
		description: 'PharoLauncher UI.';
		addDependencyOn: #'PharoLauncher-Core'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Download')
		description: 'Tests of the PharoLauncher-Download package.';
		addDependencyOn: #'PharoLauncher-Download'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Core')
		description: 'Tests of the PharoLauncher-Core package..';
		addDependencyOn: #'PharoLauncher-Core'.
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
	^ CGOGitRepositoryCreator new
		url: 'https://github.com/pharo-project/pharo-launcher.git';
		version: 'development';
		subdirectory: 'src';
		create
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
