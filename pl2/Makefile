pl2: flex.l
	flex flex.l
	gcc -o pl2 lex.yy.c -ll

graph: out.dot
	dot -Tpng out.dot -o outfile.png