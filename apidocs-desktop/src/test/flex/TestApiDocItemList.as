/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/6/12
 * Time: 11:51 PM
 * To change this template use File | Settings | File Templates.
 */
package {

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayList;
    import mx.events.FlexEvent;

    import org.asforge.apidocs.desktop.view.component.ApiDocItemListView;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import org.osflash.signals.utils.proceedOnSignal;

    public class TestApiDocItemList {

        private var _apiDocItemListView:ApiDocItemListView;

        [Before(ui,async)]
        public function setUp():void {
            _apiDocItemListView = new ApiDocItemListView();
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

        private function selectRandomItem():void {
            _apiDocItemListView.list.selectedIndex = 0;
            _apiDocItemListView.list.dispatchEvent(new Event("valueCommit"));
        }

        private function performDoubleClick():void {
            _apiDocItemListView.list.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK));
        }

        private function populateApiDocItemList():void {
            _apiDocItemListView.apiDocItemList = new ArrayList([
                1, 2, 3
            ]);
        }
    }
}
