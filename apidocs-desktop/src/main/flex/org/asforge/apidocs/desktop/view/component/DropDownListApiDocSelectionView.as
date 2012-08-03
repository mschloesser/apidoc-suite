/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 4:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import mx.collections.ListCollectionView;
    import mx.states.State;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.view.IDocSelectionView;
    import org.asforge.apidocs.desktop.view.component.skin.DropDownListApiDocSelectorSkin;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import spark.components.DropDownList;
    import spark.components.SkinnableContainer;
    import spark.events.IndexChangeEvent;

    public class DropDownListApiDocSelectionView extends SkinnableContainer
            implements IDocSelectionView {

        [SkinPart(required=true)]
        public var dropDownList:DropDownList;

        private var _apiDocList:ListCollectionView;

        private var _apiDocSelected:ISignal;

        public function DropDownListApiDocSelectionView() {
            super();
            setStyle("skinClass", DropDownListApiDocSelectorSkin);

            states = [
                new State({name: "normal"}),
                new State({name: "disabled"})
            ];
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance == dropDownList) {
                dropDownList.addEventListener(IndexChangeEvent.CHANGE, handleIndexChangeEvent);
                _apiDocSelected = new Signal(ApiDoc);
            }
        }

        private function handleIndexChangeEvent(event:IndexChangeEvent):void {
            _apiDocSelected.dispatch(dropDownList.selectedItem);
        }

        override protected function getCurrentSkinState():String {
            return currentState;
        }

        [Bindable]
        public function get apiDocList():ListCollectionView {
            return _apiDocList;
        }

        public function set apiDocList(value:ListCollectionView):void {
            _apiDocList = value;
            invalidateSkinState();
        }

        public function get apiDocSelected():ISignal {
            return _apiDocSelected;
        }

        public function set state(state:String):void {
            currentState = state;
            invalidateSkinState();
        }
    }
}
