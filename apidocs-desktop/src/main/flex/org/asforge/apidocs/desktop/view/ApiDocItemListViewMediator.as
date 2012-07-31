/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 5:49 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import mx.collections.ListCollectionView;
    import mx.controls.Alert;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.service.IApiDocItemService;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.robotlegs.mvcs.Mediator;

    public class ApiDocItemListViewMediator extends Mediator {

        [Inject]
        public var view:IApiDocItemListView;

        [Inject]
        public var itemService:IApiDocItemService;

        [Inject]
        public var apiDocSelectedSignal:ApiDocSelectedSignal;

        override public function onRegister():void {
            super.onRegister();

            view.itemSelected.add(onItemSelected);
            itemService.itemsFound.add(onItemsFound);
            itemService.errorOccurred.add(onErrorOccurred);

            apiDocSelectedSignal.add(onApiDocSelected);
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            itemService.queryItems(apiDoc);
        }

        private function onItemSelected(item:ApiDocItem):void {
            navigateToURL(new URLRequest(item.url));
        }

        private function onErrorOccurred():void {
            Alert.show("An error occurred");
        }

        private function onItemsFound(items:ListCollectionView):void {
            view.apiDocItemList = items;
        }
    }
}
