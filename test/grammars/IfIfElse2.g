grammar IfIfElse2;

options {
language = Dart;
}

@header {part of if_if_else2;}

@parser::members{
List log = new List();
}

start : statement+ ;
statement : 'x' | ifStatement;
ifStatement : 'if' 'y' statement ('else' statement|) {log.add($text);};
ID : 'a'..'z'+ ;
WS : (' '|'\n') -> channel(HIDDEN);