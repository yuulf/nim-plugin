//package org.nim;
//
//import com.intellij.lang.LanguageParserDefinitions;
//import com.intellij.lexer.Lexer;
//import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
//import com.intellij.openapi.editor.colors.TextAttributesKey;
//import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
//import com.intellij.psi.tree.IElementType;
//import org.nim.lang.NimLanguage;
//import org.nim.psi.NimTypes;
//import org.jetbrains.annotations.NotNull;
//
//import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;
//
//public class NimSyntaxHighlighter extends SyntaxHighlighterBase {
//    public static final TextAttributesKey KEYWORD = createTextAttributesKey("NIM_KEYWORD", DefaultLanguageHighlighterColors.KEYWORD);
//    public static final TextAttributesKey OPIDENT = createTextAttributesKey("NIM_OPIDENT", DefaultLanguageHighlighterColors.FUNCTION_DECLARATION);
//    public static final TextAttributesKey STRING = createTextAttributesKey("NIM_STRING", DefaultLanguageHighlighterColors.STRING);
//    public static final TextAttributesKey COMMENT = createTextAttributesKey("NIM_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
//
//    private static final TextAttributesKey[] KEYWORD_KEYS = new TextAttributesKey[]{KEYWORD};
//    private static final TextAttributesKey[] OPIDENT_KEYS = new TextAttributesKey[]{OPIDENT};
//    private static final TextAttributesKey[] STRING_KEYS = new TextAttributesKey[]{STRING};
//    private static final TextAttributesKey[] COMMENT_KEYS = new TextAttributesKey[]{COMMENT};
//    private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];
//
//    @NotNull
//    @Override
//    public Lexer getHighlightingLexer() {
//        return LanguageParserDefinitions.INSTANCE.forLanguage(NimLanguage.INSTANCE).createLexer(null);
//    }
//
//    @NotNull
//    @Override
//    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
//        if (tokenType.equals(NimTypes.KEYWORD) ||
//            tokenType.equals(NimTypes.OP_ADDR) ||
//            tokenType.equals(NimTypes.T_VAR) ||
//            tokenType.equals(NimTypes.T_LET) ||
//            tokenType.equals(NimTypes.T_CONST) ||
//            tokenType.equals(NimTypes.T_IMPORT) ||
//            tokenType.equals(NimTypes.T_PROC) ||
//            tokenType.equals(NimTypes.T_IF) ||
//            tokenType.equals(NimTypes.T_ELIF) ||
//            tokenType.equals(NimTypes.T_ELSE) ||
//            tokenType.equals(NimTypes.T_FOR) ||
//            tokenType.equals(NimTypes.T_IN) ||
//            tokenType.equals(NimTypes.T_WHILE) ||
//            tokenType.equals(NimTypes.T_CASE) ||
//            tokenType.equals(NimTypes.T_OF) ||
//            tokenType.equals(NimTypes.T_BREAK) ||
//            tokenType.equals(NimTypes.NIL) ||
//            tokenType.equals(NimTypes.T_TRUE) ||
//            tokenType.equals(NimTypes.T_FALSE) ||
//            tokenType.equals(NimTypes.T_BLOCK) ||
//            tokenType.equals(NimTypes.T_DISCARD) ||
//            tokenType.equals(NimTypes.T_RETURN)
//           ) {
//            return KEYWORD_KEYS;
//        } else if (tokenType.equals(NimTypes.OPERATOR_IDENTIFIER)) {
//            return OPIDENT_KEYS;
//        } else if (tokenType.equals(NimTypes.COMMENT)) {
//            return COMMENT_KEYS;
//        } else if (tokenType.equals(NimTypes.STRING)) {
//            return STRING_KEYS;
//        } else if (tokenType.equals(NimTypes.COMMENT)) {
//            return COMMENT_KEYS;
//        } else {
//            return EMPTY_KEYS;
//        }
//    }
//}
