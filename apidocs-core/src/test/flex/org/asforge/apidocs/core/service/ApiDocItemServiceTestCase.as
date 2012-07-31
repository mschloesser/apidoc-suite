/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 6:16 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import mockolate.mock;
    import mockolate.verify;

    import mx.collections.IList;
    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.parser.IApiDocParser;
    import org.asforge.apidocs.core.util.ItemCache;
    import org.hamcrest.object.instanceOf;
    import org.osflash.signals.ISignal;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class ApiDocItemServiceTestCase {

        [Mock]
        public var successSignal:ISignal;

        [Mock]
        public var errorSignal:ISignal;

        [Mock]
        public var parsedItems:IList;

        [Mock]
        public var cachedItems:ListCollectionView;

        [Mock]
        public var parser:IApiDocParser;

        [Mock]
        public var urlLoader:URLLoader;

        [Mock]
        public var itemCache:ItemCache;

        public var apiDoc:ApiDoc;

        public var service:ApiDocItemService;

        [Before]
        public function setUp():void {

            apiDoc = new ApiDoc();
            apiDoc.id = 1;
            apiDoc.url = "http://";

            service = new ApiDocItemService(successSignal, errorSignal);
            service.parser = parser;
            service.loader = urlLoader;
            service.itemCache = itemCache;
        }

        [Test]
        public function cacheHit():void
        {
            mock(successSignal).method("dispatch").args(cachedItems);
            mock(itemCache).method("contains").args(apiDoc.id).returns(true);
            mock(itemCache).method("retrieve").args(apiDoc.id).returns(cachedItems);
            mock(urlLoader).method("load").args(instanceOf(URLRequest)).never();

            service.queryItems(apiDoc);

            verify(urlLoader);
            verify(itemCache);
            verify(successSignal);
        }

        [Test]
        public function cacheMissAndSuccessfulLoad():void {
            mock(itemCache).method("contains").args(apiDoc.id).returns(false);
            mock(urlLoader).method("load").anyArgs().dispatches(new Event(Event.COMPLETE));
            mock(parser).method("parseApiDoc").anyArgs().returns(parsedItems);
            mock(itemCache).method("add").args(apiDoc.id, instanceOf(ListCollectionView));
            mock(successSignal).method("dispatch").args(instanceOf(ListCollectionView));

            service.queryItems(apiDoc);

            verify(urlLoader);
            verify(parser);
            verify(itemCache);
            verify(successSignal);
        }

        [Test]
        public function cacheMissAndIOErrorOnLoad():void {
            mock(errorSignal).method("dispatch").once();
            mock(itemCache).method("contains").args(apiDoc.id).returns(false);
            mock(itemCache).method("add").anyArgs().never();
            mock(itemCache).method("retrieve").anyArgs().never();
            mock(urlLoader).method("load")
                    .args(instanceOf(URLRequest))
                    .dispatches(new IOErrorEvent(IOErrorEvent.IO_ERROR));

            service.queryItems(apiDoc);

            verify(errorSignal);
            verify(urlLoader);
            verify(itemCache);
        }

        [Test]
        public function cacheMissAndSecurityErrorOnLoad():void {
            mock(errorSignal).method("dispatch").once();
            mock(itemCache).method("contains").args(apiDoc.id).returns(false);
            mock(itemCache).method("add").anyArgs().never();
            mock(itemCache).method("retrieve").anyArgs().never();
            mock(urlLoader).method("load")
                    .args(instanceOf(URLRequest))
                    .dispatches(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));

            service.queryItems(apiDoc);

            verify(errorSignal);
            verify(urlLoader);
            verify(itemCache);
        }
    }
}
