/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 11:06 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.view.component.ListFilterView;
    import org.robotlegs.mvcs.Mediator;

    public class FilterViewMediator extends Mediator {

        [Inject]
        public var view:ListFilterView;

        [Inject]
        public var itemModel:ApiDocItemModel;

        override public function onRegister():void {
            super.onRegister();

            view.filterChanged.add(onFilterChanged);
        }

        private function onFilterChanged():void {
            itemModel.applyFilter(view.textInput.text, view.regExpSwitch.selected);
        }
    }
}
