/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/3/12
 * Time: 7:47 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.as3.v1 {

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class As3DocParserTestCase {

        private var source:String;

        private var parser:As3DocParser;

        [Before]
        public function setUp():void { 
            source = StaticResources.getAs3DocSource();
            parser = new As3DocParser();
            parser.itemExtractor = new As3DocItemExtractor();
        }

        [Test]
        public function testtest():void {
            assertThat(parser.parseApiDoc(source).length, equalTo(2));
        }

        [Test]
        public function detectItems():void {
            assertThat(parser.detectItems(source).length, equalTo(2));
        }

    }
}
