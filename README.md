# Verified Lenses in agda2hs
This repository contains an implementation of lenses written and verified in [Agda], that can be translated to Haskell using [agda2hs]. This project is a part of [the Research Project at the Delft University of Technology](https://cse3000-research-project.github.io/), iteration 2022 Q4. 

## Structure
All Agda source files are contained in `src/`, all resulting Haskell files after translating with agda2hs are found in `lib/`. Within these directories, the library is structured as follows:
* `Control/Lens.[agda|hs]` - Definition of the Lens record type and its methods.
* `Control/Lens/Record.[agda|hs]` - Example definition of a record type and a lens that operates on it.
* `Control/Lens/Tuple.[agda|hs]` - Lenses `one` and `two` for operating on a 2-tuple's first and second field respectively.
* `Control/Lens/List.[agda|hs]` - A non-well-behaved `ix i` lens constructor for lenses that operate on list indices.
* `Control/Lens/Vec.agda` - A lens that operates on Agda's `Vec` type. Not translated to Haskell.

## Prerequisites:

To use this repository it is necessary to have cabal, ghc and make installed. If
you don't have these installed you can follow the instructions below, else you
can continue on to [here.](#dependencies)

### For Windows (Using Chocolately):

It is recommended that you install chocolately as a package manager that allows
for installing software by using the built-in terminal in Windows. For the
latest instruction on installing chocolately [click
here](https://chocolatey.org/install#individual) and use the individual
installation method.

To install all prerequisites execute the following commands in your terminal:
```
choco install ghc cabal make
refreshenv
```

Now you can go ahead and install the dependencies.

## Dependencies

This template relies on [agda2hs], [Agda], and [agda-stdlib].
To build them from source, do the following:

```
git clone https://github.com/flupe/verification-template
cd verification-template
cabal install Agda    # If there are conflicting dependencies for base use the following flag: --allow-newer=base
cabal install agda2hs # If there are conflicting dependencies for base use the following flag: --allow-newer=base
```

Building Agda may take a while.

Follow the [standard library's instructions](https://github.com/agda/agda-stdlib/blob/master/notes/installation-guide.md) to install it.

In order to use the Haskell prelude of `agda2hs` from your Agda code, you also
need to tell Agda where to locate the library.

Clone agda2hs:

```
git clone https://github.com/agda/agda2hs
```
### For Unix:

Inside the file `~/.agda/libraries`, add the following line:

```
/your/path/to/agda2hs/agda2hs.agda-lib
/your/path/to/agda-stdlib/standard-library.agda-lib
```

### For Windows:

First off execute the following command:

```
(test-path -path $home\AppData\Roaming\agda\libraries -pathtype Leaf) ? (echo "File not created, it already exists") : (new-item -path $home\AppData\Roaming\agda\libraries)
```

Either add the following line to `C:\Users\<USER>\AppData\Roaming\agda\libraries` or alternatively when using powershell `$home\AppData\Roaming\agda\libraries`, 

```
</your/path/to/agda2hs/agda2hs.agda-lib>
</your/path/to/agda-stdlib/standard-library.agda-lib>
```

Or run the following commands in powershell:

```
add-content $home\AppData\Roaming\agda\libraries "`n</your/path/to/agda2hs/agda2hs.agda-lib>"
add-content $home\AppData\Roaming\agda\libraries "`n</your/path/to/agda2hs/standard-library.agda-lib>"
```

*You will have to create this file if it does not exist.*

## Development

You should be good to go. Open any file in the `src/` directory inside your IDE of choice and
you should be able to use the Haskell prelude in your code without any issue.

Running `make` at the root of the project will:
- compile `Everything.agda` using `agda2hs`.
  Don't forget to import your agda files in `Everything.agda` to have them
  compile to Haskell automatically.
- compile the Haskell library generated from the Agda files in `lib/`.
- comile the demo Haskell executable in `demo/`

[Agda]:    https://github.com/agda/Agda
[agda2hs]: https://github.com/agda/agda2hs
[agda-stdlib]: https://github.com/agda/agda-stdlib

To run the demo executable, just launch `cabal run demo`.

To test out your library in a REPL, use `cabal repl project`.
