build:
	cd src; \
	ghc --make Build.hs -o ../build ; \
	ghc --make Learn.hs -o ../learn ; \
	ghc --make Remind.hs -o ../remind ; \
	ghc --make CutLast.hs -o ../cut-last ; \
	ghc --make CutFirst.hs -o ../cut-first

clean:
	rm -rf ./src/*.o ./src/*.hi build learn remind cut-last cut-first *.bak *.dat doc/

doc:
	mkdir doc
	haddock -o ./doc --html ./src/Random.hs ./src/Neural.hs ./src/Tools.hs
