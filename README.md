FLEX program to turn an XML file into a Dot diagram

After running the program a documental tree is generated with the structure of the elements in the XML file.

Example of a generated dot file:

strict digraph g {
x -> y ;
a -> b ;
a -> x ;
x -> c ;
}


After that it's possible to use that file to generate an image representation between the nodes (man dot in terminal to know more)

![graphical representation of the dot file]https://raw.githubusercontent.com/a79014/plpriv/master/graph_example.jpg
