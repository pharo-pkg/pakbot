# Tutorial: How to work with a Cargo Package Repository?

Before starting this tutorial, please ensure you already have [Cargo installed](https://github.com/demarey/cargo#install-cargo).

In this tutorial, we will still use the *Pharo counter example* already presented [here](https://github.com/demarey/cargo/blob/master/tutorial/start-a-new-project.md#counter)
Starting from a fresh Pharo image, the first thing you will probably do is to load an existing project into your image.

## What is a Cargo Package repository?

A Cargo repository is used to hold software packages for the Smalltalk programming language. It actually contains only package metadata with references to the source code. Cargo Package Manager is able to install a software package and its dependencies by providing it a reference to a Cargo Package reposiory where sostware artifacts can be found.

Cargo has a default package repository that aims to store package versions of OSS Smalltalk projects: the central repository. To deal with proprietary code, you can host your own package repository in your company.

## Create a Cargo Package repository
Cargo comes with a simple implementation of a package repository relying on the file system. It means that you do not need to install anything to enable this kind of repository that will be persistent outside the image.
By default, Cargo will use the central remote repository to search for or to publish packages. This default repository can be changed as following to use a local, file system-based package repository:
```smalltalk
Cargo useLocalRepository: '/tmp/cargo-local-repo'.
```
It will create the package repository structure and set it as the default Cargo repository.

## Publish packages to a package repository.

Let us load the Pharo counter project into the image and publish the current version to the Cargo repository:
```smalltalk
Cargo new 
    useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter.git');
    project: #'Counter';
    install.
project := CGOPackageRegistry default packageNamed: 'Counter'.
project publishAll.
 ```
Once the project installed, you can publish the project to the package repository using `project publish`. It will publish ONLY the project metadata to the default Cargo package repository (currently set to use your local repository located in '/tmp/cargo-local-repo'). Instead of the `#publish` message, you can use the `#publishAll` message to publish the project AND all packages (units, assemblies) part of it.

Let us now load the Pharo counter UI project:
```smalltalk
Cargo new 
    useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter-ui.git');
    project: #'Counter-UI';
    install.
uiproject := (CGOPackageRegistry default packageNamed: 'Counter-UI') asOngoingProject.
```
We define a missing assembly:
```smalltalk
(uiproject newPackageAssembly: #'Counter-UI-Tests')
    description: 'Counter UI + counter packages';
    parts: #('Counter-UI-Spec' 'Counter-Tests');
    yourself.
```
Then we publish thr project:
```smalltalk
uiproject publishAll.
 ```
## Load a project, an assembly or any package
In [How to start a new project with Cargo?](https://github.com/demarey/cargo/blob/master/tutorial/start-a-new-project.md#load-both-a-project-and-its-dependents-from-scm), we saw how to load a project from a Source Code Management system. In this section, we will do the same operation, i.e. load a project or a package, but from a package repository.

In a fresh pharo image, with Cargo already loaded, we will load the Counter project from our local Cargo repository:
```smalltalk
Cargo useLocalRepository: '/tmp/cargo-local-repo'.
Cargo new 
    package: #'Counter';
    install.
```
It will load the *Counter* project ant its two package units: *Counter-Core* and *Counter-Tests*.
We can also ask to load a package assembly like *Counter-UI-Tests*:
```smalltalk
Cargo new 
    package: #'Counter-UI-Tests';
    install.
```
It will load parts of the package assembly: the package units *Counter-UI-Spec* and *Counter-Tests*. In this case, only *Counter-UI-Spec* will be loaded as *Counter-Tests* was already loaded in the image before we ran this command.
As you can see, with Cargo, you can load the same way a project, a package assembly or a package unit as they all are packages.

## Dealing with many package repositories
### Mixed mode: loading some packages from a package repository, some others from SCM
#### Prepare a Cargo package repository where the Counter project is published
You can first [load the counter project](https://github.com/demarey/cargo/blob/master/tutorial/start-a-new-project.md#load-the-project-in-a-new-image-from-scm) from the SCM.
Then publih it to a package repository:
```smalltalk
Cargo useLocalRepository: '/tmp/counter-repo'.
project := (CGOPackageRegistry default packageNamed: 'Counter').
project publishAll.
```
#### Loading packages from different sources
In a fresh image (no counter nor counter-ui project installed), you can easily load packages both from a SCM and a Cargo package repository:
```smalltalk
Cargo new 
    useSourceRepository: (CGOGitRepository repositoryUrl:'git@github.com:demarey/pharo-counter-ui.git');
    useLocalRepository: '/tmp/counter-repo';
    package: #'Counter-UI';
   install.
```
Cargo will iterate on its repositories, starting from source repositories (SCM), in the declared order, to find packages. If a package is found in a repository, the search stops and the package is retrieved from this repository.
### Mixed mode: loading packages from the central package repository, some others from a private package repository
We can use the same messages we saw in the previous section to load some packages from the central package repository, some others from a private package repository.
```smalltalk
Cargo initialize. "Cargo comes with the central repository as default repository. We just ensure here that we will use the central repository if the default has changed!"
Cargo new 
    useLocalRepository: '/tmp/counter-repo';
    package: #'Counter-UI';
   install.
```
