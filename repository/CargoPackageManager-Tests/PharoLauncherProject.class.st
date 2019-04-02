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
	project addDependency: 
		(PBMetacelloBaselineProjectDependency  
			name: 'Icetray'
			repositoryUrl: 'https://github.com/pharo-spec/icetray.git'
			version: #master).
	project addDependency: 
		(PBMetacelloBaselineProjectDependency  
			name: 'FastTableExtentions'
			repositoryUrl: 'https://github.com/sbragagnolo/FastTableExtention.git' "/src"
			version: #master).
	project addDependency: 
		(PBMetacelloBaselineProjectDependency  
			name: 'TaskIt'
			repositoryUrl: 'https://github.com/sbragagnolo/taskit.git'
			version: 'v1.0.1').
	^ project
]

{ #category : #building }
PharoLauncherProject >> buildPackages [
	(project newNotLoadedPackage: #'PharoLauncher-ZipArchive')
		description: 'Package allowing to use file references with Zip Archive (integrated in Pharo 8.0).'.
	(project newNotLoadedPackage: #'PharoLauncher-Core')
		description: 'Core package with the model, commands and settings.';
		addDependencyOn: #'PharoLauncher-ZipArchive';
		addDependencyOn: #'XMLParser::Core';
		addDependencyOn: #'Ston';
		addDependencyOn: #'ProcessWrapper';
		addDependencyOn: #'OSProcess'.
	(project newNotLoadedPackage: #'PharoLauncher-Spec')
		description: 'PharoLauncher UI done in pure Spec.';
		addDependencyOn: #'PharoLauncher-Core'.
	(project newNotLoadedPackage: #'PharoLauncher-IceTray')
		description: 'PharoLauncher UI parts done with IceTray.';
		addDependencyOn: #'PharoLauncher-Core';
		addDependencyOn: #'IceTray';
		addDependencyOn: #'FastTableExtentions'.
	(project newNotLoadedPackage: #'PharoLauncher-Tests-Core')
		description: 'Tests of the PharoLauncher-Core package.';
		addDependencyOn: #'PharoLauncher-Core'.
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
			version: 'development';
			subdirectory: 'src';
			create
]
