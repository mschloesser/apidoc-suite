/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 11:06 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.asforge.apidocs.desktop.view.component.ListFilterView;
    import org.robotlegs.mvcs.Mediator;

    public class FilterViewMediator extends Mediator {

        [Inject]
        public var view:ListFilterView;

        [Inject]
        public var itemModel:ApiDocItemModel;

        [Inject]
        public var apiDocSelectedSignal:ApiDocSelectedSignal;

        override public function onRegister():void {
            super.onRegister();

            view.filterChanged.add(onFilterChanged);

            itemModel.itemService.itemsFound.add(onItemsFound);
            itemModel.itemService.errorOccurred.add(onItemsFound);
            apiDocSelectedSignal.add(onApiDocSelected);
        }

        private function onItemsFound(list:ListCollectionView = null):void {
            view.state = "normal";
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            view.state = "disabled";
            view.resetFilter();
        }

        private function onFilterChanged():void {
            itemModel.applyFilter(view.textInput.text, view.regExpSwitch.selected);
        }
    }
}
