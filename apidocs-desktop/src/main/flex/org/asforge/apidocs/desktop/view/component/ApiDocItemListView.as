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
    import org.asforge.apidocs.desktop.view.IApiDocItemListView;
    import org.asforge.apidocs.desktop.view.component.skin.ApiDocItemListSkin;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import spark.components.List;
    import spark.components.SkinnableContainer;

    [SkinState("normal")]
    [SkinState("disabled")]
    
    public class ApiDocItemListView extends SkinnableContainer implements IApiDocItemListView {

        [SkinPart(required=true)]
        public var list:List;

        private var _apiDocItemList:ListCollectionView;

        private var _itemSelected:ISignal;

        public function ApiDocItemListView() {
            super();
            setStyle("skinClass", ApiDocItemListSkin);
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
            return apiDocItemList !== null && apiDocItemList.length > 0 ? "normal" : "disabled";
        }

        [Bindable]
        public function get apiDocItemList():ListCollectionView {
            return _apiDocItemList;
        }

        public function set apiDocItemList(value:ListCollectionView):void {
            _apiDocItemList = value;
            invalidateSkinState();
        }

        public function get itemSelected():ISignal {
            return _itemSelected;
        }
    }
}
