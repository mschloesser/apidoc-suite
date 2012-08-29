/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/6/12
 * Time: 10:21 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.java.v2 {

    import mx.collections.IList;

    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class JavaDocParserTestCase {

        private var source:String;

        private var parser:JavaDocParser;
        
        [Before]
        public function setUp():void {
            source = StaticResources.getJavaDocV2Source();
            parser = new JavaDocParser();
        }

        [Test]
        public function detectItems():void {
            var result:Vector.<String> = parser.detectItems(source);
            assertThat(result.length, equalTo(4));
        }

        [Test]
        public function extractAnnotation():void {

            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(3).name, equalTo("Action"));
            assertThat(result.getItemAt(3).packageName, equalTo("javax.xml.ws"));
            assertThat(result.getItemAt(3).type, equalTo(ApiDocItemType.ANNOTATION));
        }

        [Test]
        public function extractInterface():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(1).name, equalTo("AbstractDocument.AttributeContext"));
            assertThat(result.getItemAt(1).packageName, equalTo("javax.swing.text"));
            assertThat(result.getItemAt(1).type, equalTo(ApiDocItemType.INTERFACE));
        }

        [Test]
        public function extractClass():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(0).name, equalTo("AbstractAction"));
            assertThat(result.getItemAt(0).packageName, equalTo("javax.swing"));
            assertThat(result.getItemAt(0).type, equalTo(ApiDocItemType.CLASS));
        }

        [Test]
        public function extractEnum():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(2).name, equalTo("AbstractRegionPainter.PaintContext.CacheMode"));
            assertThat(result.getItemAt(2).packageName, equalTo("javax.swing.plaf.nimbus"));
            assertThat(result.getItemAt(2).type, equalTo(ApiDocItemType.ENUM));
        }
    }
}
