package org.nim.grammar;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import static org.nim.psi.NimTokenTypes.*;

%%

%public %class NimLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%{

    protected int previousState = START;
    protected int runnableSpaces = 0;
    protected int spaces = 0;

    public int getPreviousState(){
        return previousState;
    }

%}

    _LETTER = [a-zA-Z\u8000-\uFF00]
    ONE_NL = \R                                                        // NewLines
    _WHITE_SPACE = " " | \t | \f | \\ {ONE_NL}
    STRING_ESC = \\ [^] | \\ ({WHITE_SPACE})+ (\n|\r)
    DOUBLE_QUOTED_CONTENT = {STRING_ESC} | [^\"\\$\n\r]
    DOUBLE_QUOTED_LITERAL = \" {DOUBLE_QUOTED_CONTENT}* \"
    STRING_NL = {ONE_NL}
    TRIPLE_DOUBLE_QUOTED_CONTENT = {DOUBLE_QUOTED_CONTENT} | {STRING_NL} | \"(\")?[^\"\\$]
    TRIPLE_DOUBLE_QUOTED_LITERAL = \"\"\" {TRIPLE_DOUBLE_QUOTED_CONTENT}* ~"\"\"\""
    RAW_STRING = "r\"" ({DOUBLE_QUOTED_CONTENT}|"\\"| "\"\"")* ~"\""
    IDENTIFIER= {_LETTER} ( _? {_LETTER} | {DEC_DIGIT} )*

// Eventually push the number stuff to the parser so we can add error inspections
    // Digit Classes
    DEC_DIGIT = [0-9]
    OCTAL_DIGIT = [0-7]
    BINARY_DIGIT = [01]
    HEX_DIGIT = [0-9A-Fa-f]

    //Digit First Half of Suffix

    _SIGNED = "'"?[iI]
    _UNSIGNED = "'"?[uU]

    //We Don't make ' Optional because it is required on Hex Digits
    _FLOAT = [fF]
    _DOUBLE = [dD]


    UNDERSCORE = '_'
    WHITE_SPACE=" "

    DEC_LIT =   {DEC_DIGIT}+ ( "_"? {DEC_DIGIT} )*
    HEX_LIT =   "0" [xX]  {HEX_DIGIT}+ ( "_"? {HEX_DIGIT} )*
    OCT_LIT =   "0" [ocC] {OCTAL_DIGIT}+ ("_"? {OCTAL_DIGIT} )*
    BIN_LIT =   "0" [bB]  {BINARY_DIGIT}+ ( "_"? {BINARY_DIGIT} )*

    _INT_LIT   =  {DEC_LIT}|{OCT_LIT}|{BIN_LIT}|{HEX_LIT}

    INT_LIT    =  {_INT_LIT}
    INT8_LIT   =  {_INT_LIT}  {_SIGNED}   "8"
    INT16_LIT  =  {_INT_LIT}  {_SIGNED}   "16"
    INT32_LIT  =  {_INT_LIT}  {_SIGNED}   "32"
    INT64_LIT  =  {_INT_LIT}  {_SIGNED}   "64"

    UINT_LIT   =  {_INT_LIT}  {_UNSIGNED}
    UINT8_LIT  =  {_INT_LIT}  {_UNSIGNED} "8"
    UINT16_LIT =  {_INT_LIT}  {_UNSIGNED} "16"
    UINT32_LIT =  {_INT_LIT}  {_UNSIGNED} "32"
    UINT64_LIT =  {_INT_LIT}  {_UNSIGNED} "64"

    EXPONENT = [eE][\-\+] {DEC_DIGIT}+ ( "_"? {DEC_DIGIT})*

    _READABLE_DEC = {DEC_DIGIT} ("_"? {DEC_DIGIT})*

    FLOAT_LIT = {_READABLE_DEC} ("." {_READABLE_DEC}*) {EXPONENT}

    _HEX_FLOAT = {HEX_LIT} "'"
    _NON_HEX_FLOAT = ({FLOAT_LIT} | {DEC_LIT} | {OCT_LIT} | {BIN_LIT}) "'"?

    FLOAT32_SUFFIX = {_FLOAT} "32"
    FLOAT32_LIT = ( {_HEX_FLOAT} | {_NON_HEX_FLOAT} ) {FLOAT32_SUFFIX}

    FLOAT64_SUFFIX = ({_FLOAT} "64") | {_DOUBLE}
    FLOAT64_LIT = ( {_HEX_FLOAT} | {_NON_HEX_FLOAT} ) {FLOAT64_SUFFIX}


    BLOCK_COMMENT_START="#["
    BLOCK_COMMENT_END="]#"
    TRIPLE_QUOTE="\"\"\""
    DOUBLE_QUOTE="\""
    SINGLE_LINE_COMMENT="#" [^\n\r]*
    ADDR = "addr"
    AND = "and"
    AS = "as"
    ASM = "asm"
    BIND = "bind"
    BLOCK = "block"
    BREAK = "break"
    CASE = "case"
    CAST = "cast"
    CONCEPT ="concept"
    CONSY = "const"
    CONTINUE = "continue"
    CONVERTER="converter"
    DEFER="defer"
    DISCARD="discard"
    DISTINCT="distinct"
    DIV="div"
    DO="do"
    ELIF="elif"
    ELSE="else"
    END="end"
    ENUM="enum"
    EXCEPT="except"
    EXPORT="export"
    FINALLY="finally"
    FOR="for"
    FROM="from"
    FUNC="func"
    IF="if"
    IMPORT="import"
    IN="in"
    INCLUDE="include"
    INTERFACE="interface"
    IS="is"
    ISNOT="isnot"
    ITERATOR="iterator"
    LET="let"
    MACRO="macro"
    METHOD="method"
    MIXIN="mixin"
    MOD="mod"
    NIL="nil"
    NOT="not"
    NOTIN="notin"
    OBJECT="object"
    OF="of"
    OR="or"
    OUT="out"
    PROC="proc"
    PTR="ptr"
    RAISE="raise"
    REF="ref"
    RETURN="return"
    SHL="shl"
    SHR="shr"
    STATIC="static"
    TEMPLATE="template"
    TRY="try"
    TUPLE="tuple"
    TYPE="type"
    USING="using"
    VAR="var"
    WHEN="when"
    WHILE="while"
    XOR="xor"
    YIELD="yield"
    PARAN_DOT_OPEN ="(."
    PARAN_DOT_CLOSE=".)"
    BRACKET_DOT_OPEN="[."
    BRACKET_DOT_CLOSE=".]"
    CURLY_DOT_OPEN="{."
    CURLY_DOT_CLOSE=".}"
    PARAN_OPEN="("
    PARAN_CLOSE=")"
    BRACKET_OPEN="["
    BRACKET_CLOSE="]"
    CURLY_OPEN="{"
    CURLY_CLOSE="}"
    COMMA=","
    SEMI_COLON=";"
    DOUBLE_COLON="::"
    SINGLE_COLON=":"
    EQUAL="="
    COMPARISON=[>|<]=?
    DOUBLE_DOT=".."
    DOT="."
    BRACKET_COLON="[:"
    BACK_TICK_IDENTIFIER=[^`]
    BACK_TICK="`"
    STAR="*"
    PLUS="+"
    MINUS="-"
    OP_OR="|"
    PERCENT="%"
    AMP="&"
    DOLLAR="$"
    AT="@"
    CRLF=[\n|\r\n]





%state START CALLABLE RUNNABLE_EXAMPLE CALLABLE_BACK_TICK CALLABLE_ARGUMENTS IN_STRING IN_TRIPLE_STRING COMMENT MULTILINE_COMMENT

%%
//Reset Spaces
<YYINITIAL>{
    " " {
            this.spaces++;
            return WHITE_SPACE;
        }
    . {
   if(!zzAtEOF){
         yybegin(this.previousState);

         yypushback(1);
     }

  }

}
<YYINITIAL, START, CALLABLE, RUNNABLE_EXAMPLE, CALLABLE_ARGUMENTS> {

    {CRLF} {
          this.spaces = 0;
          if(YYINITIAL != yystate()){
              //We want to be able to pop back to the previous state
            this.previousState = yystate();
          }
          yybegin(YYINITIAL);
          return CRLF;
      }
}
 //For Indent Couting


<START> {
//  {CRLF} {
//          this.spaces = 0;
//          if(YYINITIAL != yystate()){  //We want to be able to pop back to the previous state
//            this.previousState = yystate();
//          }
//          yybegin(YYINITIAL);
//          return CRLF;
//      }
    "runnableExamples:" {
          yybegin(RUNNABLE_EXAMPLE);
          this.runnableSpaces = this.spaces;
          return EXAMPLE;
      }
    {WHITE_SPACE} {return WHITE_SPACE;}
    "proc" {yybegin(CALLABLE); return PROC;}
    {FLOAT_LIT} {return FLOAT_LIT;}
    {FLOAT32_LIT} {return FLOAT32_LIT;}
    {FLOAT64_LIT} {return FLOAT64_LIT;}
    {INT8_LIT} {return INT8_LIT;}
    {INT16_LIT} {return INT16_LIT;}
    {INT32_LIT} {return INT32_LIT;}
    {INT64_LIT} {return INT64_LIT;}
    {STAR} {return STAR;}
    {UINT_LIT} {return UINT_LIT;}
    {UINT8_LIT} {return UINT8_LIT;}
    {UINT16_LIT} {return UINT16_LIT;}
    {UINT32_LIT} {return UINT32_LIT;}
    {UINT64_LIT} {return UINT64_LIT;}
    {INT_LIT} {return INT_LIT; }
    {RAW_STRING} {return RAW_STRING;}
    {BLOCK_COMMENT_START} {return BLOCK_COMMENT_START;}
    {BLOCK_COMMENT_END} {return BLOCK_COMMENT_END;}
    ">" {return GREATER_THAN;}
    "<" {return LESS_THAN;}
    {SINGLE_LINE_COMMENT} {return SINGLE_LINE_COMMENT;}
    "addr" {return ADDR;}
    "and" {return AND;}
    "as" {return AS;}
    "asm" {return ASM;}
    "bind" {return BIND;}
    "block" {return BLOCK;}
    "break" {return BREAK;}
    "case" {return CASE;}
    "cast" {return CAST;}
    "concept" {return CONCEPT;}
    "consy" {return CONSY;}
    "continue" {return CONTINUE;}
    "converter" {return CONVERTER;}
    "defer" {return DEFER;}
    "discard" {return DISCARD;}
    "distinct" {return DISTINCT;}
    "div" {return DIV;}
    "do" {return DO;}
    "elif" {return ELIF;}
    "else" {return ELSE;}
    "end" {return END;}
    "enum" {return ENUM;}
    "except" {return EXCEPT;}
    "export" {return EXPORT;}
    "finally" {return FINALLY;}
    "for" {return FOR;}
    "from" {return FROM;}
    "func" {return FUNC;}
    "if" {return IF;}
    "import" {return IMPORT;}
    "in" {return IN;}
    "include" {return INCLUDE;}
    "interface" {return INTERFACE;}
    "is" {return IS;}
    "isnot" {return ISNOT;}
    "iterator" {return ITERATOR;}
    "let" {return LET;}
    "macro" {return MACRO;}
    "method" {return METHOD;}
    "mixin" {return MIXIN;}
    "mod" {return MOD;}
    "nil" {return NIL;}
    "not" {return NOT;}
    "notin" {return NOTIN;}
    "object" {return OBJECT;}
    "of" {return OF;}
    "or" {return OR;}
    "out" {return OUT;}
    "ptr" {return PTR;}
    "raise" {return RAISE;}
    "ref" {return REF;}
    "return" {return RETURN;}
    "shl" {return SHL;}
    "shr" {return SHR;}
    "static" {return STATIC;}
    "template" {return TEMPLATE;}
    "try" {return TRY;}
    "tuple" {return TUPLE;}
    "type" {return TYPE;}
    "using" {return USING;}
    "var" {return VAR;}
    "when" {return WHEN;}
    "while" {return WHILE;}
    "xor" {return XOR;}
    "yield" {return YIELD;}
    "(." {return PARAN_DOT_OPEN;}
    ".)" {return PARAN_DOT_CLOSE;}
    "[." {return BRACKET_DOT_OPEN;}
    ".]" {return BRACKET_DOT_CLOSE;}
    "{." {return CURLY_DOT_OPEN;}
    ".}" {return CURLY_DOT_CLOSE;}
    "(" {return PARAN_OPEN;}
    ")" {return PARAN_CLOSE;}
    "[" {return BRACKET_OPEN;}
    "]" {return BRACKET_CLOSE;}
    "{" {return CURLY_OPEN;}
    "}" {return CURLY_CLOSE;}
    "," {return COMMA;}
    ";" {return SEMI_COLON;}
    "::" {return DOUBLE_COLON;}
    ":" {return SINGLE_COLON;}
    "=" {return EQUAL;}
    ".." {return DOUBLE_DOT;}
    "." {return DOT;}
    "[:" {return BRACKET_COLON;}
    "~" {return TILDE;}
{TRIPLE_DOUBLE_QUOTED_LITERAL} {return TRIPLE_DOUBLE_STR; }
    "-" {return MINUS;}
    "+" {return PLUS;}
    "|" {return OP_OR;}
    "&" {return AMP;}
    "$" {return DOLLAR;}
    "@" {return AT;}

    "<=" {return LT_EQUAL;}
    ">=" {return GT_EQUAL;}
    "==" {return EQUALS; }
    {IDENTIFIER} {return IDENTIFIER;}

}

<CALLABLE>{
    {PROC} {return PROC;}
    {BACK_TICK} {yybegin(CALLABLE_BACK_TICK); return BACK_TICK;}
    {IDENTIFIER} {return IDENTIFIER;}
    {BRACKET_OPEN} {return BRACKET_OPEN;}
    {BRACKET_CLOSE} {return BRACKET_CLOSE;}
    {PARAN_OPEN} {yybegin(CALLABLE_ARGUMENTS); return PARAN_OPEN; }
    {PARAN_CLOSE} {return PARAN_CLOSE; }
    {SINGLE_COLON} {return SINGLE_COLON;}
      "," {return COMMA;}
    {STAR} {return STAR;}
    {CURLY_DOT_OPEN} {return CURLY_DOT_OPEN; }
    {CURLY_DOT_CLOSE} {return CURLY_DOT_CLOSE; }
    {EQUAL} { yybegin(START); return EQUAL;}
    {WHITE_SPACE} {return WHITE_SPACE;}
}
<CALLABLE_ARGUMENTS>{
    {WHITE_SPACE} {return WHITE_SPACE;}
    {PROC} {return PROC;}
    {BRACKET_OPEN} {return BRACKET_OPEN;}
    {BRACKET_CLOSE} {return BRACKET_CLOSE;}
    {COMMA} {return COMMA; }
    {PARAN_OPEN} {return PARAN_OPEN; }
    {PARAN_CLOSE} {yybegin(CALLABLE); return PARAN_CLOSE;}
    {SINGLE_COLON} {return SINGLE_COLON;}
    {VAR} {return VAR; }
    {EQUAL} {return EQUAL; }
    {IDENTIFIER} {return IDENTIFIER;}
}

<CALLABLE_BACK_TICK> {
    {BACK_TICK_IDENTIFIER} { return BACK_TICK_IDENTIFIER; }
    {BACK_TICK} { yybegin(CALLABLE);return BACK_TICK; }
}

//Worry about this crap later
<RUNNABLE_EXAMPLE> {
    [^\n]* {
          if(spaces <= this.runnableSpaces){
              this.previousState = START;
              yybegin(START);
              yypushback(yylength());
          } else {
              this.previousState = RUNNABLE_EXAMPLE;
              yybegin(YYINITIAL);
              return DOC_RUNNABLE;
          }
      }
}