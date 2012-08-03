/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/6/12
 * Time: 11:51 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component{

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.events.FlexEvent;

    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.osflash.signals.utils.proceedOnSignal;

    public class TestApiDocItemList {

        private var _apiDocItemListView:ItemListView;

        [Before(ui,async)]
        public function setUp():void {
            _apiDocItemListView = new ItemListView();
            Async.proceedOnEvent(this, _apiDocItemListView, FlexEvent.CREATION_COMPLETE);
            UIImpersonator.addChild(_apiDocItemListView);
        }

        [After(ui,async)]
        public function tearDown():void {
            UIImpersonator.removeChild(_apiDocItemListView);
            _apiDocItemListView = null;
        }

        [Test(async)]
        public function doubleClickOnSelectedItemDispatchesItemSelectedSignal():void {
            populateApiDocItemList();
            selectRandomItem();
            proceedOnSignal(this, _apiDocItemListView.itemSelected);
            performDoubleClick();
        }

        [Test]
        public function listViewIsDisabledIfEmpty():void {
            assertThat(_apiDocItemListView.skin.currentState, equalTo("disabled"));
        }

        [Test(async)]
        public function listViewIsEnabledIfNotEmpty():void {
            populateApiDocItemList();

            var result:Function = function(event:FlexEvent, passThroughData:Object):void {
                assertThat(_apiDocItemListView.skin.currentState, equalTo("normal"));
            };
            Async.handleEvent(this, _apiDocItemListView.skin, FlexEvent.STATE_CHANGE_COMPLETE, result);
        }

        private function selectRandomItem():void {
            _apiDocItemListView.list.selectedIndex = 0;
            _apiDocItemListView.list.dispatchEvent(new Event("valueCommit"));
        }

        private function performDoubleClick():void {
            _apiDocItemListView.list.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK));
        }

        private function populateApiDocItemList():void {
            _apiDocItemListView.apiDocItemList = new ArrayCollection([
                1, 2, 3
            ]);
        }
    }
}
