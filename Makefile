build:
	cd src; \
	ghc --make Build.hs -o ../build ; \
	ghc --make Learn.hs -o ../learn ; \
	ghc --make Learnsimple.hs -o ../learnsimple ; \
	ghc --make Remind.hs -o ../remind ; \
	ghc --make Remindsimple.hs -o ../remindsimple ; \
	ghc --make CutLast.hs -o ../cut-last ; \
	ghc --make CutFirst.hs -o ../cut-first

clean:
	rm -rf ./src/*.o ./src/*.hi build learn remind remindsimple learnsimple cut-last cut-first *.bak *.dat doc/

doc:
	mkdir doc
	haddock -o ./doc --html ./src/Random.hs ./src/Neural.hs ./src/Tools.hs
