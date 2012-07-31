/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 7:31 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import org.asforge.apidocs.core.exception.ItemExtractorException;
    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;
    import org.flexunit.asserts.fail;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class As3SourceExtractorTestCase {

        [Test]
        public function nonMatchingDefinitionThrowsException():void {
            try {
                var extractor:As3SourceItemExtractor = new As3SourceItemExtractor();
                extractor.extractItem("");
                fail("ItemExtractorDefinition should have been thrown");
            } catch (e:ItemExtractorException) {}
        }

        [Test]
        public function extractorProducesValidRootPackagedApiDocItem():void {

            var extractor:As3SourceItemExtractor = new As3SourceItemExtractor();
            var item:ApiDocItem = extractor.extractItem(htmlSourceForClassInRootPackage());

            assertThat(item.name, equalTo("ArgumentError"));
            assertThat(item.packageName, equalTo(""));
        }

        [Test]
        public function extractorProducesValidApiDocItemOfTypeClass():void {

            var extractor:As3SourceItemExtractor = new As3SourceItemExtractor();
            var item:ApiDocItem = extractor.extractItem(htmlSourceForClass());
            
            assertThat(item.name, equalTo("AAAARecord"));
            assertThat(item.packageName, equalTo("flash.net.dns"));
            assertThat(item.type, equalTo(ApiDocItemType.CLASS));
        }

        [Test]
        public function extractorProcucesValidApiDocItemOfTypeInterface():void {
            var extractor:As3SourceItemExtractor = new As3SourceItemExtractor();
            var item:ApiDocItem = extractor.extractItem(htmlSourceForInterface());

            assertThat(item.name, equalTo("IList"));
            assertThat(item.packageName, equalTo("mx.collections"));
            assertThat(item.type, equalTo(ApiDocItemType.INTERFACE));
        }

        private function htmlSourceForClass():String {
            return '<a name="ftr" ' +
                    'href="" ' +
                    'target="_self" ' +
                    'title="flash.net.dns.AAAARecord" ' +
                    'onclick="svScrl(this);" ' +
                    'oncontextmenu="svScrl(this);" ' +
                    'runtime="AIR::2##" ' +
                    'languageversion="3.0">AAAARecord&nbsp;' +
                    '<span class="sprite AirIcon12x12" ' +
                    'alt="AIR-only" ' +
                    'title="Only available in the AIR runtime">&nbsp;&nbsp;&nbsp;' +
                    '</span><br>' +
                    '</a>';
        }

        private function htmlSourceForInterface():String {
            return '<a name="ftr" ' +
                    'href="" ' +
                    'target="_self" ' +
                    'title="mx.collections.IList" ' +
                    'onclick="svScrl(this);" ' +
                    'oncontextmenu="svScrl(this);" ' +
                    'runtime="Flash::9##AIR::1.1##" ' +
                    'product="Flex::3##" ' +
                    'languageversion="3.0">' +
                    '<i>IList</i><br>' +
                    '</a>';
        }

        private function htmlSourceForClassInRootPackage():String {
            return '<a name="ftr" href="" target="_self" title="ArgumentError" onclick="svScrl(this);" oncontextmenu="svScrl(this);" runtime="Flash::9##AIR::1.0##Lite::4##" languageversion="3.0">ArgumentError<br></a>';
        }
    }
}
