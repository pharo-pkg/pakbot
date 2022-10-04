# Tutorial: How to start a new project with Pakbot?

Before starting this tutorial, please ensure you already have [Pakbot installed](https://github.com/pharo-pkg/pakbot#install-pakbot).

## Counter 
For this tutorial, we will use a tiny project: Counter. It is basically the same example as the seaside counter. A counter has a value that can be incremented or decremented.

We first implement a *#'Counter-Core'* package that will contain a Counter class. We will also create a *#'Counter-Tests'* package that will contain a *CounterTest* class.
Here are the st files with the code already ready to use:
- [Counter-Core.st](https://raw.githubusercontent.com/pharo-pkg/pakbot/master/tutorial/Counter-Core.st)
- [Counter-Tests.st](https://raw.githubusercontent.com/pharo-pkg/pakbot/master/tutorial/Counter-Tests.st)

At the end of this tutorial, *Counter* project will have 2 package units:
- *Counter-Core*
- *Counter-Tests* that depends on *Counter-Core*

We will also use the already existing *Counter-UI* project composed of 1 package unit: *Counter-UI-Spec*.

## Pakbot Project creation
Pakbot comes with a browser allowing fast creation and visualisation of Pakbot projects.
First, onpen a Pakbot browser with:
```smalltalk
PakbotBrowser new run.
``` 
![Pakbot browser](/tutorial/images/pakbot-browser.png)

We will click on the `Add project` button.
![Pakbot new project dialog](/tutorial/images/pakbot-new-project.png)
Fill-in the following information:
- name: Counter
- version: 0.1-dev
- repository:
	- name: counter
	- local directory: <use default value>
	- source directory: src (default value)
- description: 'A simple counter project. You can increment it, decrement it and get the value from the counter.'

A Pakbot project holds the meta-information on a software project: its source repository, name, desription, packages composing the project, etc.
Once created, the project is added to the **Pakbot registry** that holds the list of installed projects into the system.

<!--We will ask Cargo to create a new project by giving it a name: 'Counter'. We also specify the initial version, a description of the project and a repository definition (it is best to create your own repository).
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
``` -->

## Add a package unit
Now we will add a package to the newly created project. 
Select the project, rigth-click on it and select: **import package** menu item. Indeed, we already have defined the packages and their content (import of st files), so we on ly need to import them into the project.
The default filter for packages is set to the project name but you can edit it and add any package in the project.

![Pakbot import package dialog](/tutorial/images/pakbot-import-package.png)

<!-- It can be done easily by calling `#newPackageUnit:` on a project.
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
``` -->

## Commit the project
Now, it is time to commit our new project to the Git repository. Click on the `commit` button in the toolbar to open a preview of files that will be commited.
<!-- A Pakbot project offers a convenient function to store the whole project at once: `#saveToSCM:`. It will save the current state of packages part of the project and all the associated metadata.
``` smalltalk
project saveToSCM: 'Initial commit through Cargo.'
``` -->
![Pakbot commit project dialog](/tutorial/images/pakbot-commit.png)

The code is commited to the git local directory (in the image folder pharo-local/iceberg/git-user/repository). You still **need to push the code to the origin.**
You can do it by opening the repository view (button is in the toolbar).

## Load the project in a new image from a Git repository
You will now learn how to load your project from  a Git repository. Let us now download a fresh Pharo image with Pakbot already installed.
Open the Pakbot browser:
```smalltalk
PakbotBrowser new run.
```
Then, click on `Add project` and select `Import from git`:
Enter, your remote url, then specify the branch or tag you want.
![Pakbot import project dialog](/tutorial/images/pakbot-import-from-git.png)

Pakbot is now loading the project.
Finally, you get the project loaded.	

![Pakbot commit project dialog](/tutorial/images/pakbot-project-loaded.png)

<!-- To load a project from a Git repository, Pakbot offers the `#installProjectFromSourceRepository:` method. Just give the SourceRepository as parameter and Cargo will go through it to first load the project metadata, then to load project packages metadata, solve dependencies and install packages into the image. If no version is specified for the source repository, Cargo will use the HEAD version.
``` smalltalk
Cargo new 
	installProjectFromSourceRepository: (CGOGitRepository repositoryUrl: 'git@github.com:demarey/pharo-counter.git')
``` -->

<!-- ## Load both a project and its dependents from SCM
Cargo allows you to load project packages directly from a Source Code Management system instead of using the package repository.
This feature is especialy useful when you are developping a project. It may happen that, in development mode, you rely on external packages not yet published to the package repository. That's why Cargo propose the `#useSourceRepository:` message, taking a **CGOSourceRepository** as argument. All source repositories added will take precedence on the default repository and package metadata will be loaded from the SCM for all the project packages.

In the following example, we will load *Counter-UI* from GitHub. *Counter-UI* is a project hosting a package with a small UI that can be used together with the *Counter* project. *Counter-UI* has a *Counter-UI-Spec* package unit depending on *Counter-Core*. Loading *Counter-UI* will also be load *Counter-Core* from GitHub since we added its source repository.
``` smalltalk
Cargo new 
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter-ui.git');
	useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter.git');
	package: #'Counter-UI';
	install
```
-->