/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/16/12
 * Time: 9:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.states.State;
    import mx.validators.StringValidator;
    import mx.validators.Validator;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.view.component.skin.OptionsViewSkin;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import spark.components.Button;
    import spark.components.DataGrid;
    import spark.components.SkinnableContainer;
    import spark.events.GridItemEditorEvent;

    public class OptionsView extends SkinnableContainer {

        [SkinPart]
        public var dataGrid:DataGrid;

        [SkinPart]
        public var addApiDocButton:Button;

        [SkinPart]
        public var deleteApiDocButton:Button;

        private var _saveApiDocSignal:ISignal = new Signal(ApiDoc);
        private var _deleteButtonSignal:ISignal = new Signal(ApiDoc);

        private var _apiDocList:ListCollectionView;
        private var _apiDocListChanged:Boolean;

        private var _validators:Array;
        private var _titleValidator:StringValidator;
        private var _urlValidator:StringValidator;

        public function OptionsView() {

            setStyle("skinClass", OptionsViewSkin);
            states = [ new State({name:"normal"}), new State({name:"disabled"}) ];

            _apiDocList = new ArrayCollection();
            _validators = [];
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);

            if (instance === addApiDocButton) {
                addApiDocButton.addEventListener(MouseEvent.CLICK, handleAddButtonClick);
            } else if (instance === deleteApiDocButton) {
                deleteApiDocButton.addEventListener(MouseEvent.CLICK, handleDeleteButtonClick);
            } else if (instance === dataGrid) {
                dataGrid.addEventListener(GridItemEditorEvent.GRID_ITEM_EDITOR_SESSION_SAVE, handleItemEditEnd);
                dataGrid.addEventListener(GridItemEditorEvent.GRID_ITEM_EDITOR_SESSION_CANCEL, handleItemEditCancel);

                initializeValidators();
            }
        }

        private function handleDeleteButtonClick(event:MouseEvent):void {
            var apiDoc:ApiDoc = dataGrid.selectedItem as ApiDoc;
            if (apiDoc.id > 0) {
                _deleteButtonSignal.dispatch(apiDoc);
            } else {
                _apiDocList.removeItemAt(_apiDocList.getItemIndex(apiDoc));
            }
        }

        override protected function partRemoved(partName:String, instance:Object):void {
            super.partRemoved(partName, instance);

            if (instance === _saveApiDocSignal) {
                addApiDocButton.removeEventListener(MouseEvent.CLICK, handleAddButtonClick);
                _saveApiDocSignal.removeAll();
                _saveApiDocSignal = null;
            } else if (instance === _deleteButtonSignal) {
                deleteApiDocButton.removeEventListener(MouseEvent.CLICK, handleAddButtonClick);
                _deleteButtonSignal.removeAll();
                _deleteButtonSignal = null;
            }
        }

        private function initializeValidators():void {
            _titleValidator = new StringValidator();
            _titleValidator.property = "title";
            _titleValidator.required = true;
            _titleValidator.maxLength = 255;
            _validators.push(_titleValidator);

            _urlValidator = new StringValidator();
            _urlValidator.property = "url";
            _urlValidator.required = true;
            _urlValidator.maxLength = 255;
            _validators.push(_urlValidator);
        }

        override protected function getCurrentSkinState():String {
            return currentState;
        }

        override protected function commitProperties():void {
            super.commitProperties();

            if (_apiDocListChanged) {
                _apiDocListChanged = false;
                dataGrid.dataProvider = _apiDocList;
            }
        }

        private function handleItemEditCancel(event:GridItemEditorEvent):void {
            _apiDocList.removeItemAt(_apiDocList.getItemIndex(dataGrid.selectedItem));
        }

        private function handleAddButtonClick(event:MouseEvent):void {
            var newApiDoc:ApiDoc = new ApiDoc();
            _apiDocList.addItem(newApiDoc);
            dataGrid.selectedItem = newApiDoc;
            dataGrid.startItemEditorSession(_apiDocList.getItemIndex(newApiDoc), 0);
        }

        private function handleItemEditEnd(event:GridItemEditorEvent):void {
            _titleValidator.source = dataGrid.selectedItem;
            _urlValidator.source = dataGrid.selectedItem;

            var validationResult:Array = Validator.validateAll(_validators);
            if (validationResult.length == 0) {
                _saveApiDocSignal.dispatch(dataGrid.selectedItem);
            }
        }

        [Bindable]
        public function get apiDocList():ListCollectionView {
            return _apiDocList;
        }

        public function set apiDocList(value:ListCollectionView):void {
            _apiDocList = value;
            _apiDocListChanged = true;

            invalidateProperties();
        }

        public function get saveApiDocSignal():ISignal {
            return _saveApiDocSignal;
        }

        public function get deleteButtonSignal():ISignal {
            return _deleteButtonSignal;
        }
    }
}
