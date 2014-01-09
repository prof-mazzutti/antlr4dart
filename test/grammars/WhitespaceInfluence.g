grammar WhitespaceInfluence;

options {
language = Dart;
}

@header {part of whitespace_influence;}

@parser::members {
List log = new List();
}

prog : expression EOF;
expression
    : ID '(' expression (',' expression)* ')'               # doFunction
    | '(' expression ')'                                    # doParenthesis
    | '!' expression                                        # doNot
    | '-' expression                                        # doNegate
    | '+' expression                                        # doPositiv
    | expression '^' expression                             # doPower
    | expression '*' expression                             # doMultipy
    | expression '/' expression                             # doDivide
    | expression '%' expression                             # doModulo
    | expression '-' expression                             # doMinus
    | expression '+' expression                             # doPlus
    | expression '=' expression                             # doEqual
    | expression '!=' expression                            # doNotEqual
    | expression '>' expression                             # doGreather
    | expression '>=' expression                            # doGreatherEqual
    | expression '<' expression                             # doLesser
    | expression '<=' expression                            # doLesserEqual
    | expression K_IN '(' expression (',' expression)* ')'  # doIn
    | expression ( '&' | K_AND) expression                  # doAnd
    | expression ( '|' | K_OR) expression                   # doOr
    | '[' expression (',' expression)* ']'                  # newArray
    | K_TRUE                                                # newTrueBoolean
    | K_FALSE                                               # newFalseBoolean
    | NUMBER                                                # newNumber
    | DATE                                                  # newDateTime
    | ID                                                    # newIdentifier
    | SQ_STRING                                             # newString
    | K_NULL                                                # newNull
    ;

// Fragments
fragment DIGIT    : '0' .. '9';  
fragment UPPER    : 'A' .. 'Z';
fragment LOWER    : 'a' .. 'z';
fragment LETTER   : LOWER | UPPER;
fragment WORD     : LETTER | '_' | '$' | '#' | '.';
fragment ALPHANUM : WORD | DIGIT;  

// Tokens
ID              : LETTER ALPHANUM*;
NUMBER          : DIGIT+ ('.' DIGIT+)? (('e'|'E')('+'|'-')? DIGIT+)?;
DATE            : '\'' DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT (' ' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT ('.' DIGIT+)?)? '\'';
SQ_STRING       : '\'' ('\'\'' | ~'\'')* '\'';
DQ_STRING       : '\"' ('\\\"' | ~'\"')* '\"';
WS              : [ \t\n\r]+ -> skip ;
COMMENTS        : ('/*' .*? '*/' | '//' ~'\n'* '\n' ) -> skip;
