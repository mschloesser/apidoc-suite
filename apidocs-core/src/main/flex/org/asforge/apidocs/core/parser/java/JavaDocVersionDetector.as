/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/6/12
 * Time: 10:26 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.java {

    import mx.collections.IList;

    import org.asforge.apidocs.core.parser.IApiDocParser;
    import org.asforge.apidocs.core.parser.java.v1.JavaDocParser;
    import org.asforge.apidocs.core.parser.java.v2.JavaDocParser;

    public class JavaDocVersionDetector implements IApiDocParser {

        private static var V1_PARSER:org.asforge.apidocs.core.parser.java.v1.JavaDocParser;
        private static var V2_PARSER:org.asforge.apidocs.core.parser.java.v2.JavaDocParser;

        public function JavaDocVersionDetector() {
            V1_PARSER = new org.asforge.apidocs.core.parser.java.v1.JavaDocParser();
            V2_PARSER = new org.asforge.apidocs.core.parser.java.v2.JavaDocParser();
        }

        public function parseApiDoc(source:String):IList {
            var version:int = detectParserVersion(source);
            var parser:IApiDocParser = version == 1 ? V1_PARSER : V2_PARSER;
            return parser.parseApiDoc(source);
        }

        internal function detectParserVersion(source:String):int {
            return source.indexOf('<ul>') == -1 ? 1 : 2;
        }
    }
}
