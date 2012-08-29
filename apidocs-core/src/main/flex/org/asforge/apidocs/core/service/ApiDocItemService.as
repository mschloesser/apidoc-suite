/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 6:17 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.model.enumeration.ApiDocType;
    import org.asforge.apidocs.core.parser.DocParserProvider;
    import org.asforge.apidocs.core.parser.IApiDocParser;
    import org.asforge.apidocs.core.util.ItemCache;
    import org.osflash.signals.ISignal;

    public class ApiDocItemService implements IApiDocItemService {

        public var parser:IApiDocParser;
        public var loader:URLLoader;
        public var itemCache:ItemCache;

        private var _itemsFound:ISignal;
        private var _errorOccurred:ISignal;

        private var _cacheKey:int;

        private static const _docParserProvider:DocParserProvider = new DocParserProvider();

        public function ApiDocItemService(itemsFound:ISignal, errorOccured:ISignal) {
            _itemsFound = itemsFound;
            _errorOccurred = errorOccured;
        }


        public function queryItems(apiDoc:ApiDoc):void {
            _cacheKey = apiDoc.id;

            var type:ApiDocType = ApiDocType.byOrdinal(apiDoc.type);
            parser = _docParserProvider.getParserByType(type);

            if (itemCache.contains(_cacheKey)) {
                _itemsFound.dispatch(itemCache.retrieve(_cacheKey));
                return;
            }

            loader.addEventListener(Event.COMPLETE, onLoadComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
            loader.load(new URLRequest(apiDoc.url));
        }

        private function onError(event:Event):void {
            _errorOccurred.dispatch();
        }

        private function onLoadComplete(event:Event):void {
            var parsedItems:IList = parser.parseApiDoc(String(loader.data));

            var list:ListCollectionView = new ArrayCollection();
            list.addAll(parsedItems);

            itemCache.add(_cacheKey, list);
            _itemsFound.dispatch(list);
        }

        public function get itemsFound():ISignal {
            return _itemsFound;
        }

        public function get errorOccurred():ISignal {
            return _errorOccurred;
        }
    }
}
