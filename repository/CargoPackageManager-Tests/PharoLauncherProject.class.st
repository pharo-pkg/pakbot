"
Builder of Cargo metadata for the PharoLauncher project.

	self buildAndRegisterIn: CGOPackageRegistry new
"
Class {
	#name : #PharoLauncherProject,
	#superclass : #Object,
	#instVars : [
		'registry',
		'project'
	],
	#category : 'CargoPackageManager-Tests-LauncherRessource'
}

{ #category : #'instance creation' }
PharoLauncherProject class >> buildAndRegisterIn: aCGOPackageRegistry [
	^ self new buildAndRegisterIn: aCGOPackageRegistry
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
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency
			name: 'JSON' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'Ston'
			repositoryUrl: 'http://ss3.gemstone.com/ss/STON'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'OSProcess'
			repositoryUrl: 'http://www.squeaksource.com/MetacelloRepository'
			version: #stable).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'ProcessWrapper'
			repositoryUrl: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'
			version: #bleedingEdge).
	project addExternalCargoProject: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'XMLParser'
			repositoryUrl: 'hhttp://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).
]

{ #category : #building }
PharoLauncherProject >> buildPackages [
	(project newPackageUnit: #'PharoLauncher-Download')
		description: 'Package dealing with image / VM detection and download.';
		addDependencyOn: #'OSProcess::Core with Output';
		addDependencyOn: #'ProcessWrapper::Core'.
	(project newPackageUnit: #'PharoLauncher-Core')
		description: 'Core package with the model, commands and settings.';
		addDependencyOn: #'PharoLauncher-Download';
		addDependencyOn: #'XMLParser::Core';
		addDependencyOn: #'Ston';
		addDependencyOn: #'JSON'.
	(project newPackageUnit: #'PharoLauncher-Spec')
		description: 'PharoLauncher UI.';
		addDependencyOn: #'PharoLauncher-Core'.
	(project newPackageUnit: #'PharoLauncher-Tests-Download')
		description: 'Tests of the PharoLauncher-Download package.';
		addDependencyOn: #'PharoLauncher-Download'.
	(project newPackageUnit: #'PharoLauncher-Tests-Core')
		description: 'Tests of the PharoLauncher-Core package..';
		addDependencyOn: #'PharoLauncher-Core'.
]

{ #category : #building }
PharoLauncherProject >> buildProject [
	project := (CGOOngoingProject named: #PharoLauncher)
		description:
			'Pharo Launcher is a cross-platform application that

    lets you manage your Pharo images (launch, rename, copy and delete);
    lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);
    lets you create new images from any template,
    automatically find and download the appropriate VM to launch your images.
';
		repository: self buildRepository;
		registry: registry;
		yourself
]

{ #category : #building }
PharoLauncherProject >> buildRepository [
	^ CGOGitRepositoryCreator new
		url: 'https://github.com/pharo-project/pharo-launcher.git';
		version: 'development';
		subdirectory: 'src';
		create
]
