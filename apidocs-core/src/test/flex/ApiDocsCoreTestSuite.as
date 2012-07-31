/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/10/12
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package {

    import org.asforge.apidocs.core.dao.ApiDocDaoTestCase;
    import org.asforge.apidocs.core.parser.As3DocParserTestCase;
    import org.asforge.apidocs.core.parser.As3SourceExtractorTestCase;
    import org.asforge.apidocs.core.service.ApiDocServiceTestCase;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ApiDocsCoreTestSuite {

        public var as3DocParserTestCase:As3DocParserTestCase;
        public var as3SourceItemExtractor:As3SourceExtractorTestCase;
        public var apiDocDaoTestCase:ApiDocDaoTestCase;
        public var apiDocServiceTestCase:ApiDocServiceTestCase;

    }
}
