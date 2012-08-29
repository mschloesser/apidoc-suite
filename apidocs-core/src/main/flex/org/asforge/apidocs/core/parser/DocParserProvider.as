/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/6/12
 * Time: 8:44 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import org.asforge.apidocs.core.model.enumeration.ApiDocType;
    import org.asforge.apidocs.core.parser.as3.As3DocVersionDetector;
    import org.asforge.apidocs.core.parser.java.JavaDocVersionDetector;

    public class DocParserProvider
    {
        private static const AS3_PARSER_VERSION_DETECTOR:As3DocVersionDetector = new As3DocVersionDetector();
        private static const JAVA_PARSER_VERSION_DETECTOR:JavaDocVersionDetector = new JavaDocVersionDetector();

        public function getParserByType(type:ApiDocType):IApiDocParser
        {
            switch (type.ordinal) {
                case ApiDocType.AS3.ordinal:
                    return AS3_PARSER_VERSION_DETECTOR;
                    break;
                case ApiDocType.JAVA.ordinal:
                    return JAVA_PARSER_VERSION_DETECTOR;
                    break;
            }
            return null;
        }

    }
}
