/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/6/12
 * Time: 11:52 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import flash.events.MouseEvent;

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.desktop.view.IItemListView;
    import org.asforge.apidocs.desktop.view.component.skin.ItemListSkin;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import spark.components.List;
    import spark.components.SkinnableContainer;

    [SkinState("normal")]
    [SkinState("disabled")]
    [SkinState("loading")]

    public class ItemListView extends SkinnableContainer implements IItemListView {

        [SkinPart(required=true)]
        public var list:List;

        private var _apiDocItemList:ListCollectionView;

        private var _itemSelected:ISignal;
        private var _state:String = "normal";

        public function ItemListView() {
            super();
            setStyle("skinClass", ItemListSkin);
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance == list) {
                list.addEventListener(MouseEvent.DOUBLE_CLICK, handleDoubleClick);
                _itemSelected = new Signal(ApiDocItem);
            }
        }

        private function handleDoubleClick(event:MouseEvent):void {
            _itemSelected.dispatch(list.selectedItem);
        }

        override protected function getCurrentSkinState():String {
            return _state;
        }

        [Bindable]
        public function get apiDocItemList():ListCollectionView {
            return _apiDocItemList;
        }

        public function set apiDocItemList(value:ListCollectionView):void {
            _apiDocItemList = value;
            _state = "normal";
            invalidateSkinState();
        }

        public function get itemSelected():ISignal {
            return _itemSelected;
        }

        public function set state(state:String):void {
            _state = state;
            invalidateSkinState();
        }
    }
}
