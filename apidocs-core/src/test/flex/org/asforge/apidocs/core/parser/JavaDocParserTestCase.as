/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/1/12
 * Time: 6:11 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import mx.collections.IList;

    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class JavaDocParserTestCase {

        private var source:String;

        private var parser:JavaDocParser;

        [Before]
        public function setUp():void {
            source = StaticResources.getJavaDocSource();
            parser = new JavaDocParser();
        }

        [Test]
        public function extractAnnotation():void {

            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(0).name, equalTo("After"));
            assertThat(result.getItemAt(0).packageName, equalTo("org.junit"));
            assertThat(result.getItemAt(0).type, equalTo(ApiDocItemType.ANNOTATION));

        }

        [Test]
        public function extractInterface():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(25).name, equalTo("Describable"));
            assertThat(result.getItemAt(25).packageName, equalTo("org.junit.runner"));
            assertThat(result.getItemAt(25).type, equalTo(ApiDocItemType.INTERFACE));
        }

        [Test]
        public function extractClass():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(2).name, equalTo("AllOf"));
            assertThat(result.getItemAt(2).packageName, equalTo("org.hamcrest.core"));
            assertThat(result.getItemAt(2).type, equalTo(ApiDocItemType.CLASS));
        }

        [Test]
        public function extractEnum():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(104).name, equalTo("AbstractContentAssistVisitor.IdentificationVariableType"));
            assertThat(result.getItemAt(104).packageName, equalTo("org.eclipse.persistence.jpa.jpql"));
            assertThat(result.getItemAt(104).type, equalTo(ApiDocItemType.ENUM));
        }

        [Test]
        public function verifyLastItem():void {
            var result:IList = parser.parseApiDoc(source);
            assertThat(result.getItemAt(result.length - 1).name, equalTo("AbstractContentAssistVisitor.IdentificationVariableType"));
        }

    }
}
