parser grammar NimParser;
options{tokenVocab=NimLexer;}


@parser::members {
    private int indentLevel = 0;

    void increment(){
        indentLevel++;
    }

    void decrement(){
        indentLevel--;
    }

    boolean isEqual(){
       return indentLevel == 0;
    }
}

pathSeparator: FORWARD_SLASH | BACK_SLASH;

symbol
    : BACK_TICK BACK_TICK_IDENTIFIER BACK_TICK
    | IDENTIFIER;

importSymbol: symbol (pathSeparator symbol)* | stringLiteral;

importAs: importSymbol (AS IDENTIFIER)?;

importSection
    : IMPORT (importAs (COMMA importAs)* )
    | IMPORT importAs EXCEPT importSymbol (COMMA importSymbol)*
    | FROM importAs IMPORT importSymbol (COMMA importSymbol)*
    ;

stringLiteral: doubleQuotedStringLiteral | rawStringLiteral | tripleQuoteStringLiteral;

doubleQuotedStringLiteral: DOUBLE_QUOTED_LITERAL;
rawStringLiteral: RAW_STRING;
tripleQuoteStringLiteral: TRIPLE_QUOTE_LITERAL;

//oneOrMoreExpressions: expr (COMMA expr)*;
////module: stmt ^* (';' | IND{=});
//module: (stmt (  (';' | IND{=}) stmt)* )?;
//comma: ',' COMMENT?;
//semicolon:';' COMMENT?;
//colon: ':' COMMENT?;
//colcom: ':' COMMENT?;
//operator:  OP0 | OP1 | OP2 | OP3 | OP4 | OP5 | OP6 | OP7 | OP8 | OP9
//         | 'or' | 'xor' | 'and'
//         | 'is' | 'isnot' | 'in' | 'notin' | 'of'
//         | 'div' | 'mod' | 'shl' | 'shr' | 'not' | 'static' | '..';
//prefixOperator: operator;
//optionalIndent: COMMENT? INDENT?;
//optPar: (IND{>} | IND{=})?;
//simpleExpr: arrowExpr (OP0 optionalIndent arrowExpr)* pragma?;
//arrowExpr: assignExpr (OP1 optionalIndent assignExpr)*;
//assignExpr: orExpr (OP2 optionalIndent orExpr)*;
//orExpr: andExpr (OP3 optionalIndent andExpr)*;
//andExpr: cmpExpr (OP4 optionalIndent cmpExpr)*;
//cmpExpr : sliceExpr (OP5 optionalIndent sliceExpr)*;
//sliceExpr : ampExpr (OP6 optionalIndent ampExpr)*;
//ampExpr : plusExpr (OP7 optionalIndent plusExpr)*;
//plusExpr : mulExpr (OP8 optionalIndent mulExpr)*;
//mulExpr : dollarExpr (OP9 optionalIndent dollarExpr)*;
//dollarExpr : primary (OP10 optionalIndent primary)*;
//symbol : '`' (KEYW|IDENT|literal|(operator|'('|')'|'['|']'|'{'|'}'|'=')+)+ '`'
//       | IDENT | KEYW;
//exprColonEqExpr: expr (':'|'=' expr)?;
//exprList: expr (comma expr)*;
//exprColonEqExprList: exprColonEqExpr (comma exprColonEqExpr)* (comma)?;
//dotExpr: expr '.' optionalIndent (symbol | '[:' exprList ']');
//explicitGenericInstantiation:'[:' exprList ']' ( '(' exprColonEqExpr ')' )?;
//qualifiedIdent: symbol ('.' optionalIndent symbol)?;
//setOrTableConstr: '{' ((exprColonEqExpr comma)* | ':' ) '}';
//castExpr: 'cast' '[' optionalIndent typeDesc optPar ']' '(' optionalIndent expr optPar ')';
//parKeyw : 'discard' | 'include' | 'if' | 'while' | 'case' | 'try'
//        | 'finally' | 'except' | 'for' | 'block' | 'const' | 'let'
//        | 'when' | 'var' | 'mixin';
////par: '(' optInd
////          ( &parKeyw (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
////          | ';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
////          | pragmaStmt
////          | simpleExpr ( ('=' expr (';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*) )? )
////                       | (':' expr (',' (exprColonEqExpr (',' exprColonEqExpr)*) )? ) ) )
////          optPar ')';
//par: '(' optionalIndent
////( &parKeyw
//          ( parKeyw (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
//          | ';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
//          | pragmaStmt
//          | simpleExpr ( ('=' expr (';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*) )? )
//                       | (':' expr (',' (exprColonEqExpr (',' exprColonEqExpr)*) )? ) ) )
//          optPar ')';
//literal: | INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
//          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
//          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
//          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
//          | CHAR_LIT
//          | NIL;
//generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;
//identOrLiteral: generalizedLit | symbol | literal
//               | par | arrayConstr | setOrTableConstr
//               | castExpr;
//tupleConstr: '(' optionalIndent (exprColonEqExpr comma?)* optPar ')';
//arrayConstr: '[' optionalIndent (exprColonEqExpr comma?)* optPar ']';
////primarySuffix: '(' (exprColonEqExpr comma?)* ')' doBlocks?
////      | doBlocks
////      | '.' optInd symbol generalizedLit?
////      | '[' optInd indexExprList optPar ']'
////      | '{' optInd indexExprList optPar '}'
////      | &( '`'|IDENT|literal|'cast'|'addr'|'type') expr; // command syntax
//primarySuffix: '(' (exprColonEqExpr comma?)* ')' doBlocks?
//      | doBlocks
//      | '.' optionalIndent symbol generalizedLit?
//      | '[' optionalIndent indexExprList optPar ']'
//      | '{' optionalIndent indexExprList optPar '}'
//      | &( '`'|IDENT|literal|'cast'|'addr'|'type') expr; // command syntax
//condExpr: expr colcom expr optionalIndent
//        ('elif' expr colcom expr optionalIndent)*
//         'else' colcom expr;
//ifExpr: 'if' condExpr;
//whenExpr: 'when' condExpr;
//pragma: '{.' optionalIndent (exprColonExpr comma?)* optPar ('.}' | '}');
//identVis: symbol opr?;  //# postfix position
//identVisDot:symbol '.' optionalIndent symbol opr?;
//identWithPragma: identVis pragma?;
//identWithPragmaDot: identVisDot pragma?;
//declColonEquals: identWithPragma (comma identWithPragma)* comma?
//                  (':' optionalIndent typeDesc)? ('=' optionalIndent expr)?;
//identColonEquals: ident (comma ident)* comma?
//     (':' optionalIndent typeDesc)? ('=' optionalIndent expr)?;
//inlTupleDecl: 'tuple'
//    '[' optionalIndent  (identColonEquals (comma|semicolon)?)*  optPar ']';
//extTupleDecl: 'tuple'
//    COMMENT? (IND{>} identColonEquals (IND{=} identColonEquals)*)?;
//tupleClass: 'tuple';
//paramList: '(' (declColonEquals  ((comma|semicolon) declColonEquals)* )? ')';
//paramListArrow: paramList? ('->' optionalIndent typeDesc)?;
//paramListColon: paramList? (':' optionalIndent typeDesc)?;
//doBlock: 'do' paramListArrow pragmas? colcom stmt;
//procExpr: 'proc' paramListColon pragmas? ('=' COMMENT? stmt)?;
//distinct: 'distinct' optionalIndent typeDesc;
//forStmt: 'for' ((identWithPragma (comma identWithPragma)*)) 'in' expr colcom stmt;
//forExpr: forStmt;
//expr: (blockExpression
//      | ifExpr
//      | whenExpr
//      | caseExpr
//      | forExpr
//      | tryExpr)
//      | simpleExpr;
//typeKeyw: 'var' | 'out' | 'ref' | 'ptr' | 'shared' | 'tuple'
//         | 'proc' | 'iterator' | 'distinct' | 'object' | 'enum';
//primary: typeKeyw typeDescK
//        |  prefixOperator* identOrLiteral primarySuffix*
//        | 'bind' primary;
//typeDesc: simpleExpr;
//typeDefAux: simpleExpr
//           | 'concept' typeClass;
//postExprBlocks: ':' stmt? ( IND{=} doBlock
//                           | IND{=} 'of' exprList ':' stmt
//                           | IND{=} 'elif' expr ':' stmt
//                           | IND{=} 'except' exprList ':' stmt
//                           | IND{=} 'else' ':' stmt )*;
//exprStmt: simpleExpr
//         (( '=' optionalIndent expr colonBody? )
//         | ( (expr (comma expr)*)
//             doBlocks
//              | macroColon
//           ))?;
//importStmt: 'import' optionalIndent expr
//              ((comma expr)*
//              | 'except' optionalIndent oneOrMoreExpressions);
//includeStmt: 'include' optionalIndent oneOrMoreExpressions;
//fromStmt: 'from' moduleName 'import' optionalIndent oneOrMoreExpressions;
//returnStmt: 'return' optionalIndent expr?;
//raiseStmt: 'raise' optionalIndent expr?;
//yieldStmt: 'yield' optionalIndent expr?;
//discardStmt: 'discard' optionalIndent expr?;
//breakStmt: 'break' optionalIndent expr?;
//continueStmt: 'break' optionalIndent expr?;
//condStmt: expr colcom stmt COMMENT?
//           (IND{=} 'elif' expr colcom stmt)*
//           (IND{=} 'else' colcom stmt)?;
//ifStmt: 'if' condStmt;
//whenStmt: 'when' condStmt;
//whileStmt: 'while' expr colcom stmt;
//ofBranch: 'of' exprList colcom stmt;
//ofBranches: ofBranch (IND{=} ofBranch)*
//                      (IND{=} 'elif' expr colcom stmt)*
//                      (IND{=} 'else' colcom stmt)?;
//caseStmt: 'case' expr ':'? COMMENT?
//            (IND{>} ofBranches DED
//            | IND{=} ofBranches);
//tryStmt: 'try' colcom stmt &(IND{=}? 'except'|'finally')
//           (IND{=}? 'except' exprList colcom stmt)*
//           (IND{=}? 'finally' colcom stmt)?;
//tryExpr: 'try' colcom stmt &(optionalIndent 'except'|'finally')
//           (optionalIndent 'except' exprList colcom stmt)*
//           (optionalIndent 'finally' colcom stmt)?;
//exceptBlock: 'except' colcom stmt;
//blockStmt: 'block' symbol? colcom stmt;
//blockExpr: 'block' symbol? colcom stmt;
//staticStmt: 'static' colcom stmt;
//deferStmt: 'defer' colcom stmt;
//asmStmt: 'asm' pragma? (STR_LIT | RSTR_LIT | TRIPLESTR_LIT);
//genericParam: symbol (comma symbol)* (colon expr)? ('=' optionalIndent expr)?;
//genericParamList: '[' optionalIndent
//  genericParam ^* (comma|semicolon) optPar ']';
//pattern: '{' stmt '}';
//indAndComment: (IND{>} COMMENT)? | COMMENT?;
//routine: optionalIndent identVis pattern? genericParamList?
//  paramListColon pragma? ('=' COMMENT? stmt)? indAndComment;
//commentStmt: COMMENT;
//section(p) = COMMENT? p / (IND{>} (p / COMMENT)^+IND{=} DED);
//constant: identWithPragma (colon typeDesc)? '=' optionalIndent expr indAndComment
//enum: 'enum' optionalIndent (symbol optionalIndent ('=' optionalIndent expr COMMENT?)? comma?)+
//objectWhen: 'when' expr colcom objectPart COMMENT?
//            ('elif' expr colcom objectPart COMMENT?)*
//            ('else' colcom objectPart COMMENT?)?;
//objectBranch: 'of' exprList colcom objectPart;
//objectBranches: objectBranch (IND{=} objectBranch)*
//                      (IND{=} 'elif' expr colcom objectPart)*
//                      (IND{=} 'else' colcom objectPart)?;
//objectCase: 'case' identWithPragma ':' typeDesc ':'? COMMENT?
//            (IND{>} objectBranches DED
//            | IND{=} objectBranches);
//objectPart: IND{>} objectPart^+IND{=} DED
//           / objectWhen / objectCase / 'nil' / 'discard' / declColonEquals;
//object: 'object' pragma? ('of' typeDesc)? COMMENT? objectPart;
//typeClassParam: ('var' | 'out')? symbol;
//typeClass: (typeClassParam (',' (pragma)? ('of' (typeDesc (',' typeDesc)*)? typeClassParam)*)?)?
//              &IND{>} stmt;
//typeDef: identWithPragmaDot genericParamList? '=' optionalIndent typeDefAux
//            indAndComment?;
//varTuple: '(' optionalIndent (identWithPragma (comma identWithPragma)*) optPar ')' '=' optionalIndent expr;
//colonBody: colcom stmt doBlocks?;
//variable: (varTuple | identColonEquals) colonBody? indAndComment;
//bindStmt: 'bind' optionalIndent (qualifiedIdent (comma qualifiedIdent)*);
//mixinStmt: 'mixin' optionalIndent (qualifiedIdent (comma qualifiedIdent)*);
//pragmaStmt: pragma (':' COMMENT? stmt)?;
//simpleStmt: ((returnStmt | raiseStmt | yieldStmt | discardStmt | breakStmt
//           | continueStmt | pragmaStmt | importStmt | exportStmt | fromStmt
//           | includeStmt | commentStmt) / exprStmt) COMMENT?;
//complexOrSimpleStmt: (ifStmt | whenStmt | whileStmt
//                    | tryStmt | forStmt
//                    | blockStmt | staticStmt | deferStmt | asmStmt
//                    | 'proc' routine
//                    | 'method' routine
//                    | 'iterator' routine
//                    | 'macro' routine
//                    | 'template' routine
//                    | 'converter' routine
//                    | 'type' section(typeDef)
//                    | 'const' section(constant)
//                    | ('let' | 'var' | 'using') section(variable)
//                    | bindStmt | mixinStmt)
//                    | simpleStmt;
//stmt: (IND{>} complexOrSimpleStmt^+(IND{=} / ';') DED)
//     / (simpleStmt (';' simpleStmt)*);
//
//
//
//
//
//
//
//
//
//
//
//
//////module: stmt ^* (';' | IND{=});
////module: (stmt (  (';' | IND{=}) stmt)* )?;
////comma: ',' COMMENT?;
////semicolon:';' COMMENT?;
////colon: ':' COMMENT?;
////colcom: ':' COMMENT?;
////operator:  OP0 | OP1 | OP2 | OP3 | OP4 | OP5 | OP6 | OP7 | OP8 | OP9
////         | 'or' | 'xor' | 'and'
////         | 'is' | 'isnot' | 'in' | 'notin' | 'of'
////         | 'div' | 'mod' | 'shl' | 'shr' | 'not' | 'static' | '..';
////prefixOperator: operator;
////optInd: COMMENT? IND?;
////optPar: (IND{>} | IND{=})?;
////simpleExpr: arrowExpr (OP0 optInd arrowExpr)* pragma?;
////arrowExpr: assignExpr (OP1 optInd assignExpr)*;
////assignExpr: orExpr (OP2 optInd orExpr)*;
////orExpr: andExpr (OP3 optInd andExpr)*;
////andExpr: cmpExpr (OP4 optInd cmpExpr)*;
////cmpExpr : sliceExpr (OP5 optInd sliceExpr)*;
////sliceExpr : ampExpr (OP6 optInd ampExpr)*;
////ampExpr : plusExpr (OP7 optInd plusExpr)*;
////plusExpr : mulExpr (OP8 optInd mulExpr)*;
////mulExpr : dollarExpr (OP9 optInd dollarExpr)*;
////dollarExpr : primary (OP10 optInd primary)*;
////symbol : '`' (KEYW|IDENT|literal|(operator|'('|')'|'['|']'|'{'|'}'|'=')+)+ '`'
////       | IDENT | KEYW;
////exprColonEqExpr: expr (':'|'=' expr)?;
////exprList: expr (comma expr)*;
////exprColonEqExprList: exprColonEqExpr (comma exprColonEqExpr)* (comma)?;
////dotExpr: expr '.' optInd (symbol | '[:' exprList ']');
////explicitGenericInstantiation:'[:' exprList ']' ( '(' exprColonEqExpr ')' )?;
////qualifiedIdent: symbol ('.' optInd symbol)?;
////setOrTableConstr: '{' ((exprColonEqExpr comma)* | ':' ) '}';
////castExpr: 'cast' '[' optInd typeDesc optPar ']' '(' optInd expr optPar ')';
////parKeyw : 'discard' | 'include' | 'if' | 'while' | 'case' | 'try'
////        | 'finally' | 'except' | 'for' | 'block' | 'const' | 'let'
////        | 'when' | 'var' | 'mixin';
//////par: '(' optInd
//////          ( &parKeyw (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
//////          | ';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
//////          | pragmaStmt
//////          | simpleExpr ( ('=' expr (';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*) )? )
//////                       | (':' expr (',' (exprColonEqExpr (',' exprColonEqExpr)*) )? ) ) )
//////          optPar ')';
////par: '(' optInd
////          ( &parKeyw (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
////          | ';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*)
////          | pragmaStmt
////          | simpleExpr ( ('=' expr (';' (complexOrSimpleStmt (';' complexOrSimpleStmt)*) )? )
////                       | (':' expr (',' (exprColonEqExpr (',' exprColonEqExpr)*) )? ) ) )
////          optPar ')';
////literal: | INT_LIT | INT8_LIT | INT16_LIT | INT32_LIT | INT64_LIT
////          | UINT_LIT | UINT8_LIT | UINT16_LIT | UINT32_LIT | UINT64_LIT
////          | FLOAT_LIT | FLOAT32_LIT | FLOAT64_LIT
////          | STR_LIT | RSTR_LIT | TRIPLESTR_LIT
////          | CHAR_LIT
////          | NIL;
////generalizedLit: GENERALIZED_STR_LIT | GENERALIZED_TRIPLESTR_LIT;
////identOrLiteral: generalizedLit | symbol | literal
////               | par | arrayConstr | setOrTableConstr
////               | castExpr;
////tupleConstr: '(' optInd (exprColonEqExpr comma?)* optPar ')';
////arrayConstr: '[' optInd (exprColonEqExpr comma?)* optPar ']';
//////primarySuffix: '(' (exprColonEqExpr comma?)* ')' doBlocks?
//////      | doBlocks
//////      | '.' optInd symbol generalizedLit?
//////      | '[' optInd indexExprList optPar ']'
//////      | '{' optInd indexExprList optPar '}'
//////      | &( '`'|IDENT|literal|'cast'|'addr'|'type') expr; // command syntax
////primarySuffix: '(' (exprColonEqExpr comma?)* ')' doBlocks?
////      | doBlocks
////      | '.' optInd symbol generalizedLit?
////      | '[' optInd indexExprList optPar ']'
////      | '{' optInd indexExprList optPar '}'
////      | &( '`'|IDENT|literal|'cast'|'addr'|'type') expr; // command syntax
////condExpr: expr colcom expr optInd
////        ('elif' expr colcom expr optInd)*
////         'else' colcom expr;
////ifExpr: 'if' condExpr;
////whenExpr: 'when' condExpr;
////pragma: '{.' optInd (exprColonExpr comma?)* optPar ('.}' | '}');
////identVis: symbol opr?;  //# postfix position
////identVisDot:symbol '.' optInd symbol opr?;
////identWithPragma: identVis pragma?;
////identWithPragmaDot: identVisDot pragma?;
////declColonEquals: identWithPragma (comma identWithPragma)* comma?
////                  (':' optInd typeDesc)? ('=' optInd expr)?;
////identColonEquals: ident (comma ident)* comma?
////     (':' optInd typeDesc)? ('=' optInd expr)?);
////inlTupleDecl: 'tuple'
////    [' optInd  (identColonEquals (comma/semicolon)?)*  optPar ']';
////extTupleDecl: 'tuple'
////    COMMENT? (IND{>} identColonEquals (IND{=} identColonEquals)*)?;
////tupleClass: 'tuple';
////paramList: '(' declColonEquals ^* (comma/semicolon) ')';
////paramListArrow: paramList? ('->' optInd typeDesc)?;
////paramListColon: paramList? (':' optInd typeDesc)?;
////doBlock: 'do' paramListArrow pragmas? colcom stmt;
////procExpr: 'proc' paramListColon pragmas? ('=' COMMENT? stmt)?;
////distinct: 'distinct' optInd typeDesc;
////forStmt: 'for' ((identWithPragma (comma identWithPragma)*)) 'in' expr colcom stmt;
////forExpr: forStmt;
////expr: (blockExpr
////      | ifExpr
////      | whenExpr
////      | caseExpr
////      | forExpr
////      | tryExpr)
////      / simpleExpr;
////typeKeyw: 'var' | 'out' | 'ref' | 'ptr' | 'shared' | 'tuple'
////         | 'proc' | 'iterator' | 'distinct' | 'object' | 'enum';
////primary: typeKeyw typeDescK;
////        /  prefixOperator* identOrLiteral primarySuffix*
////        / 'bind' primary;
////typeDesc: simpleExpr;
////typeDefAux: simpleExpr;
////           | 'concept' typeClass;
////postExprBlocks: ':' stmt? ( IND{=} doBlock
////                           | IND{=} 'of' exprList ':' stmt
////                           | IND{=} 'elif' expr ':' stmt
////                           | IND{=} 'except' exprList ':' stmt
////                           | IND{=} 'else' ':' stmt )*;
////exprStmt: simpleExpr
////         (( '=' optInd expr colonBody? )
////         / ( (expr (comma expr)*)
////             doBlocks
////              / macroColon
////           ))?;
////importStmt: 'import' optInd expr
////              ((comma expr)*
////              / 'except' optInd ((expr (comma expr)*)));
////includeStmt: 'include' optInd (expr (comma expr)*);
////fromStmt: 'from' moduleName 'import' optInd expr (comma expr)*;
////returnStmt: 'return' optInd expr?;
////raiseStmt: 'raise' optInd expr?;
////yieldStmt: 'yield' optInd expr?;
////discardStmt: 'discard' optInd expr?;
////breakStmt: 'break' optInd expr?;
////continueStmt: 'break' optInd expr?;
////condStmt: expr colcom stmt COMMENT?;
////           (IND{=} 'elif' expr colcom stmt)*
////           (IND{=} 'else' colcom stmt)?;
////ifStmt: 'if' condStmt;
////whenStmt: 'when' condStmt;
////whileStmt: 'while' expr colcom stmt;
////ofBranch: 'of' exprList colcom stmt;
////ofBranches: ofBranch (IND{=} ofBranch)*
////                      (IND{=} 'elif' expr colcom stmt)*
////                      (IND{=} 'else' colcom stmt)?;
////caseStmt: 'case' expr ':'? COMMENT?
////            (IND{>} ofBranches DED
////            | IND{=} ofBranches);
////tryStmt: 'try' colcom stmt &(IND{=}? 'except'|'finally')
////           (IND{=}? 'except' exprList colcom stmt)*
////           (IND{=}? 'finally' colcom stmt)?;
////tryExpr: 'try' colcom stmt &(optInd 'except'|'finally')
////           (optInd 'except' exprList colcom stmt)*
////           (optInd 'finally' colcom stmt)?;
////exceptBlock: 'except' colcom stmt;
////blockStmt: 'block' symbol? colcom stmt;
////blockExpr: 'block' symbol? colcom stmt;
////staticStmt: 'static' colcom stmt;
////deferStmt: 'defer' colcom stmt;
////asmStmt: 'asm' pragma? (STR_LIT | RSTR_LIT | TRIPLESTR_LIT);
////genericParam: symbol (comma symbol)* (colon expr)? ('=' optInd expr)?;
////genericParamList: '[' optInd
////  genericParam ^* (comma/semicolon) optPar ']';
////pattern: '{' stmt '}';
////indAndComment: (IND{>} COMMENT)? | COMMENT?;
////routine: optInd identVis pattern? genericParamList?
////  paramListColon pragma? ('=' COMMENT? stmt)? indAndComment;
////commentStmt: COMMENT;
////section(p) = COMMENT? p / (IND{>} (p / COMMENT)^+IND{=} DED);
////constant: identWithPragma (colon typeDesc)? '=' optInd expr indAndComment
////enum: 'enum' optInd (symbol optInd ('=' optInd expr COMMENT?)? comma?)+
////objectWhen: 'when' expr colcom objectPart COMMENT?
////            ('elif' expr colcom objectPart COMMENT?)*
////            ('else' colcom objectPart COMMENT?)?;
////objectBranch: 'of' exprList colcom objectPart;
////objectBranches: objectBranch (IND{=} objectBranch)*
////                      (IND{=} 'elif' expr colcom objectPart)*
////                      (IND{=} 'else' colcom objectPart)?;
////objectCase: 'case' identWithPragma ':' typeDesc ':'? COMMENT?
////            (IND{>} objectBranches DED
////            | IND{=} objectBranches);
////objectPart: IND{>} objectPart^+IND{=} DED
////           / objectWhen / objectCase / 'nil' / 'discard' / declColonEquals;
////object: 'object' pragma? ('of' typeDesc)? COMMENT? objectPart;
////typeClassParam: ('var' | 'out')? symbol;
////typeClass: (typeClassParam (',' (pragma)? ('of' (typeDesc (',' typeDesc)*)? typeClassParam)*)?)?
////              &IND{>} stmt;
////typeDef: identWithPragmaDot genericParamList? '=' optInd typeDefAux
////            indAndComment?;
////varTuple: '(' optInd (identWithPragma (comma identWithPragma)*) optPar ')' '=' optInd expr;
////colonBody: colcom stmt doBlocks?;
////variable: (varTuple / identColonEquals) colonBody? indAndComment;
////bindStmt: 'bind' optInd (qualifiedIdent (comma qualifiedIdent)*);
////mixinStmt: 'mixin' optInd (qualifiedIdent (comma qualifiedIdent)*);
////pragmaStmt: pragma (':' COMMENT? stmt)?;
////simpleStmt: ((returnStmt | raiseStmt | yieldStmt | discardStmt | breakStmt
////           | continueStmt | pragmaStmt | importStmt | exportStmt | fromStmt
////           | includeStmt | commentStmt) / exprStmt) COMMENT?;
////complexOrSimpleStmt: (ifStmt | whenStmt | whileStmt
////                    | tryStmt | forStmt
////                    | blockStmt | staticStmt | deferStmt | asmStmt
////                    | 'proc' routine
////                    | 'method' routine
////                    | 'iterator' routine
////                    | 'macro' routine
////                    | 'template' routine
////                    | 'converter' routine
////                    | 'type' section(typeDef)
////                    | 'const' section(constant)
////                    | ('let' | 'var' | 'using') section(variable)
////                    | bindStmt | mixinStmt)
////                    / simpleStmt;
////stmt: (IND{>} complexOrSimpleStmt^+(IND{=} / ';') DED)
////     / (simpleStmt (';' simpleStmt)*);