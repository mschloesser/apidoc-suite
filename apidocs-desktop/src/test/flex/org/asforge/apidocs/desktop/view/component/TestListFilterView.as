/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/7/12
 * Time: 8:12 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component {

    import mx.events.FlexEvent;

    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import org.osflash.signals.utils.proceedOnSignal;

    import spark.events.TextOperationEvent;

    public class TestListFilterView {

        private var _listFilterView:ListFilterView;

        [Before(async, ui)]
        public function setUp():void {
            _listFilterView = new ListFilterView();
            Async.proceedOnEvent(this, _listFilterView, FlexEvent.CREATION_COMPLETE);
            UIImpersonator.addChild(_listFilterView);
        }

        [After(ui)]
        public function tearDown():void {
            UIImpersonator.removeChild(_listFilterView);
            _listFilterView = null;
        }

        [Test]
        public function controlsAreDisabledIfListIsEmpty():void {
            
        }

        [Test(async)]
        public function dispatchesFilterChangedSignalOnTextInput():void {
            proceedOnSignal(this, _listFilterView.filterChanged);
            fakeUserInput();
        }

        private function fakeUserInput():void {
            _listFilterView.textInput.dispatchEvent(
                    new TextOperationEvent(TextOperationEvent.CHANGE));
        }
    }
}
