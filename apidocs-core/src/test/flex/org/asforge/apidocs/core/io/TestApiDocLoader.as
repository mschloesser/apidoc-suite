/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/17/12
 * Time: 3:14 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.io {

    import mockolate.mock;
    import mockolate.runner.MockolateRule;

    import mx.collections.ArrayList;

    import org.asforge.apidocs.core.parser.IApiDocParser;
    import org.flexunit.asserts.fail;
    import org.flexunit.async.Async;

    public class TestApiDocLoader {

        [Rule]
        public var mockolateRule:MockolateRule = new MockolateRule();

        [Mock]
        public var apiDocParser:IApiDocParser;

        [Mock]
        public var resourceLoader:IResourceLoader;

        [Test]
        public function testResultEvent():void {
            var url:String = "http://www.testurl.com/asdoc.html"
            resourceLoader.sourceUrl = url;
            mock(resourceLoader).method("load").once();
            mock(resourceLoader).dispatches(new ResourceLoaderEvent(ResourceLoaderEvent.RESULT, ""));

            mock(apiDocParser).method("parseApiDoc").returns(new ArrayList()).once();
            
            Async.proceedOnEvent(this, apiDocLoader, ApiDocLoaderEvent.LOADED, 500, handleTimeout);

            var apiDocLoader:IApiDocLoader = new ApiDocLoader();
            apiDocLoader.resourceLoader = resourceLoader;
            apiDocLoader.resultParser = apiDocParser;
            apiDocLoader.load();
        }

        private function handleTimeout(passThrough:Object):void {
            fail("Expected event didn't occur");
        }
    }
}
