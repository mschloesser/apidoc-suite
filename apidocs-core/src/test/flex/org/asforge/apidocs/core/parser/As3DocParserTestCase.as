/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/4/12
 * Time: 7:29 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser{

    import mx.collections.IList;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.instanceOf;

    public class As3DocParserTestCase {

        private var parser:As3DocParser;

        [Before]
        public function setUp():void {
            parser = new As3DocParser();
            parser.apiDocItemExtractor = new As3SourceItemExtractor();
        }
        
        [Test]
        public function returnsEmptyListIfEmptySource():void {
            assertThat(parser.parseApiDoc("").length, equalTo(0));
        }

        [Test]
        public function parserExtractsListOfApiDocItemsFromValidSource():void {
            var source:String = StaticResources.getAs3DocSource();
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.length, greaterThan(0));
            assertThat(result.getItemAt(0), instanceOf(ApiDocItem));
        }
    }
}
