/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/7/12
 * Time: 9:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import flash.events.MouseEvent;

    import mx.states.State;

    import org.asforge.apidocs.desktop.view.component.skin.ListFilterSkin;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import spark.components.CheckBox;
    import spark.components.SkinnableContainer;
    import spark.components.TextInput;
    import spark.components.ToggleButton;
    import spark.events.TextOperationEvent;

    [SkinState("normal")]
    [SkinState("disabled")]
    [SkinState("options")]

    public class ListFilterView extends SkinnableContainer {

        [SkinPart(required=true)]
        public var textInput:TextInput;

        [SkinPart(required=true)]
        public var regExpSwitch:CheckBox;

        [SkinPart(required=false)]
        public var toggleOptions:ToggleButton;

        public var filterChanged:ISignal;

        public function ListFilterView() {
            super();
            setStyle("skinClass", ListFilterSkin);

            states = [
                new State({name: "normal"}),
                new State({name: "disabled"}),
                new State({name: "options"})
            ];
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance == textInput) {
                textInput.addEventListener(TextOperationEvent.CHANGE, handleTextOperationChange);
                filterChanged = new Signal();
            }

            if (instance == toggleOptions) {
                toggleOptions.addEventListener(MouseEvent.CLICK, handleToggleButtonClick);
            }
        }

        private function handleTextOperationChange(event:TextOperationEvent):void {
            filterChanged.dispatch();
        }

        override protected function partRemoved(partName:String, instance:Object):void {
            super.partRemoved(partName, instance);

            if (instance == toggleOptions) {
                toggleOptions.removeEventListener(MouseEvent.CLICK, handleToggleButtonClick);
            }
        }

        override protected function getCurrentSkinState():String {
            return currentState;
        }

        private function handleToggleButtonClick(event:MouseEvent):void {
            currentState = toggleOptions.selected ? "options" : "normal";
            invalidateSkinState();
        }
    }
}
