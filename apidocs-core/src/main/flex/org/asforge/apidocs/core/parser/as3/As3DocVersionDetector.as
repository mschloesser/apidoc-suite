/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/6/12
 * Time: 8:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.as3 {

    import mx.collections.IList;

    import org.asforge.apidocs.core.parser.*;
    import org.asforge.apidocs.core.parser.as3.v1.As3DocItemExtractor;
    import org.asforge.apidocs.core.parser.as3.v1.As3DocParser;
    import org.asforge.apidocs.core.parser.as3.v2.As3v2DocParser;
    import org.asforge.apidocs.core.parser.as3.v2.As3v2SourceItemExtractor;

    public class As3DocVersionDetector implements IApiDocParser {

        private static var AS3DOC_PARSER:As3DocParser;
        private static var AS3V2DOC_PARSER:As3v2DocParser;

        public function As3DocVersionDetector() {
            AS3DOC_PARSER = new As3DocParser();
            AS3DOC_PARSER.itemExtractor = new As3DocItemExtractor();
            
            AS3V2DOC_PARSER = new As3v2DocParser();
            AS3V2DOC_PARSER.apiDocItemExtractor = new As3v2SourceItemExtractor();
        }

        public function parseApiDoc(source:String):IList {
            var version:int = detectParserVersion(source);
            var parser:IApiDocParser = version == 1 ? AS3DOC_PARSER : AS3V2DOC_PARSER;
            return parser.parseApiDoc(source);
        }

        internal function detectParserVersion(source:String):int {
            return source.indexOf('<body xmlns:xd') == -1 ? 1 : 2;
        }
    }
}
