/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/4/12
 * Time: 7:29 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser{

    import mx.collections.IList;

    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.instanceOf;

    public class TestAs3DocParser {

        [Test]
        public function returnsEmptyListIfEmptySource():void {
            var parser:As3DocParser = new As3DocParser();
            assertThat(parser.parseApiDoc("").length, equalTo(0));
        }

        [Test]
        public function parserExtactsListOfApiDocItemsFromValidSource():void {
            var source:String = StaticResources.getAs3DocSource();
            var parser:As3DocParser = new As3DocParser();
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.length, greaterThan(0));
            assertThat(result.getItemAt(0), instanceOf(Object));
        }
    }
}
