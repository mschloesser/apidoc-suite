/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/6/12
 * Time: 11:52 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import flash.events.MouseEvent;

    import mx.collections.ArrayList;

    import org.asforge.apidocs.desktop.view.component.skin.ApiDocItemListSkin;
    import org.osflash.signals.natives.NativeSignal;

    import spark.components.List;
    import spark.components.SkinnableContainer;

    public class ApiDocItemListView extends SkinnableContainer {

        [SkinPart(required=true)]
        public var list:List;

        [Bindable]
        public var apiDocItemList:ArrayList;

        public var itemSelected:NativeSignal;

        public function ApiDocItemListView() {
            super();
            setStyle("skinClass", ApiDocItemListSkin);
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance == list) {
                itemSelected = new NativeSignal(list, MouseEvent.DOUBLE_CLICK, MouseEvent);
            }
        }
    }
}
