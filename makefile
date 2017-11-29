comp: lexCompile dropLetterCompile rdevocCompile changeACompile penultCompile changeICompile changeNCompile changeQCompile changeDCompile combinePhon1 combinePhon2 combinePhon3 combinePhon4 combinePhon5 combinePhon6 combinePhon7 combineNandP inverse convert4Generation convert4Analyse

lexCompile: words.lexc ninfl.lexc vinfl.lexc deriv.lexc num.lexc nounPred.lexc
	hfst-lexc words.lexc ninfl.lexc vinfl.lexc nounPred.lexc num.lexc deriv.lexc -o lex.hfst

dropLetterCompile: dropLetter.twol
	hfst-twolc -R -i dropLetter.twol -o dropLetter.hfst

rdevocCompile: rdevoc.twol
	hfst-twolc -R -i rdevoc.twol -o rdevoc.hfst
	
changeACompile: changeA.twol
	hfst-twolc -R -i changeA.twol -o changeA.hfst

penultCompile: penult.twol
	hfst-twolc -R -i penult.twol -o penult.hfst

changeICompile: changeI.twol
	hfst-twolc -R -i changeI.twol -o changeI.hfst

changeNCompile: changeN.twol
	hfst-twolc -R -i changeN.twol -o changeN.hfst

changeQCompile: changeQ.twol
	hfst-twolc -R -i changeQ.twol -o changeQ.hfst

changeDCompile: changeD.twol
	hfst-twolc -R -i changeD.twol -o changeD.hfst		

combinePhon1: dropLetter.hfst rdevoc.hfst
	hfst-compose-intersect -1 dropLetter.hfst -2 rdevoc.hfst -o phon1.hfst
	
combinePhon2: phon1.hfst penult.hfst
	hfst-compose-intersect -1 phon1.hfst -2 penult.hfst -o phon2.hfst

combinePhon3: phon2.hfst changeA.hfst
	hfst-compose-intersect -1 phon2.hfst -2 changeA.hfst -o phon3.hfst

combinePhon4: phon3.hfst changeI.hfst
	hfst-compose-intersect -1 phon3.hfst -2 changeI.hfst -o phon4.hfst	

combinePhon5: phon4.hfst changeN.hfst
	hfst-compose-intersect -1 phon4.hfst -2 changeN.hfst -o phon5.hfst

combinePhon6: phon5.hfst changeQ.hfst
	hfst-compose-intersect -1 phon5.hfst -2 changeQ.hfst -o phon6.hfst

combinePhon7: phon6.hfst changeD.hfst
	hfst-compose-intersect -1 phon6.hfst -2 changeD.hfst -o phon7.hfst

combineNandP: lex.hfst phon7.hfst
	hfst-compose-intersect -1 lex.hfst -2 phon7.hfst -o az.hfst

inverse: az.hfst
	hfst-invert -i az.hfst -o az.inv.hfst
	
convert4Generation: az.hfst
	hfst-fst2fst -O -i az.hfst -o az.ol

convert4Analyse: az.inv.hfst
	hfst-fst2fst -O -i az.inv.hfst -o az.inv.ol

abbas:
	hfst-fst2strings az.hfst >> verbInflectionOutput.txt
