/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.asforge.apidocs.desktop.signal.DocSelectedSignal;
    import org.robotlegs.mvcs.Mediator;

    public class DocSelectionViewMediator extends Mediator {

        [Inject]
        public var view:IDocSelectionView;

        [Inject]
        public var model:ApiDocModel;

        [Inject]
        public var apiDocSelectedSignal:DocSelectedSignal;

        [Inject]
        public var itemModel:ApiDocItemModel;

        override public function onRegister():void {
            view.apiDocList = model.findAll();
            view.apiDocSelected.add(onApiDocSelected);

            itemModel.itemService.itemsFound.add(onItemsFound);
            itemModel.itemService.errorOccurred.add(onItemsFound);
        }

        private function onItemsFound(list:ListCollectionView = null):void {
            view.state = "normal";
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            view.state = "disabled";
            apiDocSelectedSignal.dispatch(apiDoc);
        }
    }
}
