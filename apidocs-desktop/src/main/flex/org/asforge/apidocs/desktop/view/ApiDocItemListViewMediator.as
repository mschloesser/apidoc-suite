/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 5:49 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;
    import mx.controls.Alert;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.robotlegs.mvcs.Mediator;

    public class ApiDocItemListViewMediator extends Mediator {

        [Inject]
        public var view:IApiDocItemListView;

        [Inject]
        public var model:ApiDocItemModel;

        [Inject]
        public var apiDocSelectedSignal:ApiDocSelectedSignal;

        override public function onRegister():void {
            super.onRegister();

            model.itemService.itemsFound.add(onItemsFound);
            model.itemService.errorOccurred.add(onErrorOccurred);
            view.itemSelected.add(onItemSelected);

            apiDocSelectedSignal.add(onApiDocSelected);
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            view.state = "loading";
        }

        private function onErrorOccurred():void {
            Alert.show("An error occurred");
        }

        private function onItemsFound(list:ListCollectionView):void {
            view.apiDocItemList = list;
        }

        private function onItemSelected(item:ApiDocItem):void {
            model.openItem(item);
        }
    }
}
