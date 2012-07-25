/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/10/12
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
package {

    import org.asforge.apidocs.core.dao.ApiDocDaoTestCase;
    import org.asforge.apidocs.core.parser.TestAs3DocParser;
    import org.asforge.apidocs.core.service.ApiDocServiceTestCase;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ApiDocsCoreTestSuite {

        public var testAs3DocParser:TestAs3DocParser;
        public var apiDocDaoTestCase:ApiDocDaoTestCase;
        public var apiDocServiceTestCase:ApiDocServiceTestCase;

    }
}
