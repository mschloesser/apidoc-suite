/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 4:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import mx.collections.IList;

    import org.asforge.apidocs.desktop.view.IApiDocSelector;
    import org.asforge.apidocs.desktop.view.component.skin.DropDownListApiDocSelectorSkin;
    import org.osflash.signals.natives.NativeSignal;

    import spark.components.DropDownList;
    import spark.components.SkinnableContainer;
    import spark.events.IndexChangeEvent;

    [SkinState("normal")]
    [SkinState("disabled")]

    public class DropDownListApiDocSelectionView extends SkinnableContainer
            implements IApiDocSelector {

        [SkinPart(required=true)]
        public var dropDownList:DropDownList;

        private var _apiDocList:IList;

        public var apiDocSelected:NativeSignal;

        public function DropDownListApiDocSelectionView() {
            super();
            setStyle("skinClass", DropDownListApiDocSelectorSkin);
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance == dropDownList) {
                apiDocSelected = new NativeSignal(dropDownList, IndexChangeEvent.CHANGE, IndexChangeEvent);
            }
        }

        override protected function getCurrentSkinState():String {
            return apiDocList !== null && apiDocList.length > 0 ? "normal" : "disabled";
        }

        [Bindable]
        public function get apiDocList():IList {
            return _apiDocList;
        }

        public function set apiDocList(value:IList):void {
            _apiDocList = value;
            invalidateSkinState();
        }
    }
}