/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 4:53 PM
 * To change this template use File | Settings | File Templates.
 */
package {

    import mx.collections.ArrayList;
    import mx.collections.IList;
    import mx.events.FlexEvent;

    import org.asforge.apidocs.desktop.model.ApiDoc;
    import org.asforge.apidocs.desktop.view.component.DropDownListApiDocSelectionView;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.osflash.signals.utils.proceedOnSignal;

    import spark.events.IndexChangeEvent;

    public class TestApiDocSelectionView {
        private var _apiDocSelectionView:DropDownListApiDocSelectionView;

        [Before(async, ui)]
        public function setUp():void {
            _apiDocSelectionView = new DropDownListApiDocSelectionView();
            Async.proceedOnEvent(this, _apiDocSelectionView, FlexEvent.CREATION_COMPLETE, 500);
            UIImpersonator.addChild(_apiDocSelectionView);
        }

        [After(ui)]
        public function tearDown():void {
            UIImpersonator.removeChild(_apiDocSelectionView);
            _apiDocSelectionView = null;
        }

        [Test(async, ui)]
        public function indexChangeDispatchesApiDocSelectedSignal():void {
            populateDropDownList();
            proceedOnSignal(this, _apiDocSelectionView.apiDocSelected, 500);
            selectRandomApiDoc();
        }

        [Test(ui)]
        public function selectionViewIsDisabledIfListIsEmpty():void {
            assertThat(_apiDocSelectionView.skin.currentState, equalTo("disabled"));
        }

        [Ignore]
        [Test(ui)]
        public function selectionViewIsEnabledIfListIsPopulated():void {
            populateDropDownList();
            assertThat(_apiDocSelectionView.skin.currentState, equalTo("normal"));
        }

        private function selectRandomApiDoc():void { 
            const oldIndex:int = -1;
            const newIndex:int = int(Math.random() % 99) % _apiDocSelectionView.dropDownList.dataProvider.length;
            var indexChangeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE,
                    false, false, oldIndex, newIndex);
            _apiDocSelectionView.dropDownList.dispatchEvent(indexChangeEvent);
        }

        private function populateDropDownList():void {
            var apiDocList:IList = new ArrayList();
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            _apiDocSelectionView.apiDocList = apiDocList;
        }
    }
}
