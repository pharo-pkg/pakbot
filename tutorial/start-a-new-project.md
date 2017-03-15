# Tutorial: How to start a new project with Cargo?

Before starting this tutorial, please ensure you already have [Cargo installed](https://github.com/demarey/cargo#install-cargo).

## Counter 
For this tutorial, we will use a tiny project: Counter. It is basically the same example as the seaside counter. A counter has a value that can be incremented or decremented.

We first implement a *#'Counter-Core'* package that will contain a Counter class. We will also create a *#'Counter-Tests'* package that will contain a *CounterTest* class.
Here are the st files with the code already ready to use:
- [Counter-Core.st](./Counter-Core.st)
- [Counter-Tests.st](./Counter-Tests.st)

## Cargo Project creation
A Cargo project holds the meta-information on a software project: its source repository, name, desription, packages composing the project, etc.
We will ask Cargo to create a new project by giving it a name: 'Counter'. We also specify the initial version, a description of the project and a repository definition.
```smalltalk
project := (CGOOngoingProject for: #'Counter')
		version: '0.1-dev';
		description: 'A simple counter project. You can increment it, decrement it and get the value from the counter.';
		repository: (CGOGitRepository
			repositoryUrl: 'git@github.com:demarey/pharo-counter.git'
			"subdirectory: 'repository'");
		yourself.
```
A Cargo project is a read-only object, so we use a Cargo ongoing project to be able to edit it. It can be converted to a Cargo project later. The projet repository has to be a Cargo source repository object (either Git or Monticello). It contains all the information to get data (packages or metadata) from a source repository.
Once the project created, it has to be registered in the Cargo registry so that Cargo knows that the project is already loaded.
```smalltalk
CGOPackageRegistry default 
	register: project 
```
The **Cargo Package Registry** holds the list of installed packages into the system.

## Add a package unit
Now we will add a package to the newly created project. It can be done easily by calling `#newPackageUnit:` on a project.
```smalltalk
(project newPackageUnit: #'Counter-Core')
	description: 'Core package with the counter implementation.';
	yourself.
```
A package unit may have dependencies. You can add them by refering to a package unit name.
```smalltalk
(project newPackageUnit: #'Counter-Tests')
	description: 'Test package of the counter implementation.';
	addDependencyOn: #'Counter-Core';
	yourself.
```

## Save the project
Now, it is time to save our new project to the Source Code Management system (e.g. git). A Cargo project offers a convenient function to store the whole project at once: `#saveToSCM:`. It will save the current state of packages part of the project and all the associated metadata.
``` smalltalk
project saveToSCM: 'Initial commit through Cargo.'
```
*Note: for git backend, the code is commited to the local directory (check in the image folder pharo-local/iceberg/git-user/repository). You still need to push the code to the origin.*

## Load the project in a new image from SCM
You will now learn how to load your project from your prefered Source Code Management system. Let us now download a fresh Pharo image with Cargo already installed.

To load a project from a SCM, Cargo offers the `#installProjectFromSourceRepository:` method. Just give the SourceRepository as parameter and Cargo will go through it to first load the project metadata, then to load project packages metadata, solve dependencies and install packages into the image. If no version is specified for the source repository, Cargo will use the HEAD version.
``` smalltalk
Cargo new 
	installProjectFromSourceRepository: (CGOGitRepository repositoryUrl: 'git@github.com:demarey/pharo-counter.git')
```

## Load both a project and its dependents from SCM
Cargo allows you to load project packages directly from a Source Code Management system instead of using the package repository.
This feature is especialy useful when you are developping a project. It may happen that, in development mode, you rely on external packages not yet published to the package repository. That's why Cargo propose the `#useSourceRepository:` message, taking a **CGOSourceRepository** as argument. All source repositories added will take precedence on the default repository and package metadata will be loaded from the SCM for all the project packages.

In the following example, we will load *Counter-UI* from GitHub. Its dependent *Counter-Core* will also be loaded from GitHub since we added its source repository.
``` smalltalk
Cargo new 
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter-ui.git');
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter.git');
	package: #'Counter-UI';
	install
```
