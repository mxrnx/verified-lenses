.PHONY: default build run agda haskell clean

default: build

build: agda haskell

agda:
	@echo == Compiling Agda code ==
	agda2hs -olib -i. Everything.agda

haskell:
	@echo == Compiling Haskell code ==
	cabal build all

run:
	dist-newstyle/build/x86_64-linux/ghc-8.10.7/project-0.0.0/x/demo/build/demo/demo

clean:
	rm build _build dist-newstyle -rf
