/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 5:55 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.model {

    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.service.IApiDocItemService;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.robotlegs.mvcs.Actor;

    public class ApiDocItemModel extends Actor {

        [Inject]
        public var itemService:IApiDocItemService;

        [Inject]
        public var apiDocSelectedSignal:ApiDocSelectedSignal;

        private var _selectedApiDoc:ApiDoc;
        private var itemList:ListCollectionView;
        private var _filterText:String;
        private var _regExpEnabled:Boolean;

        public function ApiDocItemModel(apiDocSelectedSignal:ApiDocSelectedSignal) {
            this.apiDocSelectedSignal = apiDocSelectedSignal;
            this.apiDocSelectedSignal.add(onApiDocSelected);
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            _selectedApiDoc = apiDoc;
            itemService.queryItems(_selectedApiDoc);
            itemService.itemsFound.add(onItemsFound);
        }

        private function onItemsFound(list:ListCollectionView):void {
            itemList = list;
            itemList.filterFunction = filterList;
        }

        private function filterList(item:ApiDocItem):Boolean {
            if (_filterText.length == 0) return true;
            
            if (_regExpEnabled) {
                return (new RegExp(_filterText, "i")).test(item.name);
            } else {
                return item.name.toLowerCase().indexOf(_filterText.toLowerCase()) == 0;
            }
        }

        public function openItem(item:ApiDocItem):void {
            var url:String = _selectedApiDoc.url.substring(0, _selectedApiDoc.url.lastIndexOf("/")) + "/" + item.url;
            navigateToURL(new URLRequest(url), "_blank");
        }

        public function applyFilter(text:String, regExpEnabled:Boolean):void {
            _filterText = text;
            _regExpEnabled = regExpEnabled;
            itemList.refresh();
        }
    }
}
