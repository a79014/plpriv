%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    char* stack[4096];
    int stacksize;
    int flag = 0;
    void push(char *tag);
    char* pop();

%}

%x TAG
%x CLOSETAG

%%
"<?xml".*">" ;
"<!DOCTYPE".*">" ;
"<" BEGIN(TAG);
"</" BEGIN(CLOSETAG);
"/"/\> BEGIN(CLOSETAG);
. ;

<TAG>[a-zA-Z0-9\_\-]+ {
    if (!flag) push(strdup(yytext));
    flag = 1;
}
<TAG>"/>" {
    char* tag = pop(); 
    if(stacksize > 0)
        printf("%s -> %s\n", stack[stacksize-1], tag);
    flag = 0;
    BEGIN(0);
}
<TAG>">" {
    flag = 0;
    BEGIN(0);
}
<TAG>. ;

<CLOSETAG>">" {
    char* tag = pop(); 
    if(stacksize > 0)
        printf("%s -> %s\n", stack[stacksize-1], tag);
    BEGIN(0);
    }
<CLOSETAG>. ;

%%


int main(){
    printf("strict digraph g {\n");
    yylex();
    stacksize = 0;
    printf("}\n");
    return 0;
}

void push(char* tag) {
    if(stacksize > 4095){
        printf("Error stack size limit reached!\n");
        return;
    }
    stack[stacksize] = malloc(strlen(tag));
    stack[stacksize] = tag;
    stacksize++;
}

char* pop(){
    //todo: free memory
    if(stacksize < 1) return NULL;

    char* tag = strdup(stack[stacksize-1]);
    stacksize--;
    return tag;
}

