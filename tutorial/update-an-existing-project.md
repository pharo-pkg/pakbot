# Tutorial: How to update an existing Cargo project?

Before starting this tutorial, please ensure you already have [Cargo installed](https://github.com/demarey/cargo#install-cargo).

In this tutorial, we will still use the *Pharo counter example* already presented [here](https://github.com/demarey/cargo/blob/master/tutorial/start-a-new-project.md#counter)
Starting from a fresh Pharo image, the first thing you will probably do is to load an existing project into your image.

At the end of this tutorial, the already existing Counter-UI project will have 1 package unit and 1 package assembly:
* Counter-UI-Spec (already exisiting)
* Counter-UI-Tests composed of Counter-UI-Spec and Counter-Tests.



## Load both a project and its dependents
We saw in the [How to start a new project with Cargo?](https://github.com/demarey/cargo/blob/master/tutorial/start-a-new-project.md#load-both-a-project-and-its-dependents-from-scm) the way to load a project directly from the SCM.

We will again load *Counter-UI* from GitHub. Its dependent *Counter-Core* will also be loaded from GitHub since we added its source repository.
``` smalltalk
Cargo new 
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter-ui.git');
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter.git');
	package: #'Counter-UI';
	install
```

## Add a package assembly to a Cargo project
Imagine that now we want to add a new package to our Counter-UI project. To add a new package assembly, you first need to get the Cargo project that will host this assembly.
``` smalltalk
project := (CGOPackageRegistry default packageNamed: 'Counter-UI') project asOngoingProject.
```
The Cargo registry keeps a reference on all packages (projects, package units, package assemblies) installed in the image. You can get them by sending the `#packageNamed:` message. You will get a read-only (frozen) Cargo project that we will convert to an editable version (through #asOngoingProject) and then add a package to it.

Once you have the ongoing project, you can create an Assembly and set its properties by calling setters:
``` smalltalk
(project newPackageAssembly: #'Counter-UI-Tests')
	description: 'Counter UI + counter packages';
	parts: #('Counter-UI-Core' 'Counter-Tests');
	yourself.
```
It will automatically add the package assembly named *#'Counter-UI-Tests'* to the project. This new assembly is just a convenience package to load two packages at once. Loading *#'Counter-UI-Tests'* will trigger the load of both *#'Counter-UI-Core'* and *#'Counter-Tests'* but also their dependencies.
Then, the project can be saved:
``` smalltalk
project saveToSCM: 'Add #Counter-UI-Tests assembly.'
```

## Edit the metadata of an existing package
To edit the metadata of an existing package, get this package by asking it to the Cargo registry (the package has to be loaded). Then convert this package so it becomes editable by sending the #asOngoingPackageVersion message.
``` smalltalk
cargoPackage := (CGOPackageRegistry default packageNamed: 'Counter-Core') asOngoingPackageVersion.
```

Then, you can create an Assembly and set its properties by calling setters:
``` smalltalk
cargoPackage 
	description: 'Counter UI + counter packages';
	version: '2.0'.
```
Do not forget to save the project to do not loose your metadata changes!

*__Note__: To save Cargo metadata, the only way (for now) is to use the #saveToSCM method on a Cargo project. Tools like Monticello and iceberg cannot save files that are not Smalltalk code.*
