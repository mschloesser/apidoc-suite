/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 4:53 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view.component{

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.events.FlexEvent;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
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

        [Test]
        public function selectionViewIsDisabledIfListIsEmpty():void {
            assertThat(_apiDocSelectionView.skin.currentState, equalTo("disabled"));
        }

        [Test(async)]
        public function selectionViewIsEnabledIfListIsPopulated():void {
            populateDropDownList();
            var result:Function = function(event:FlexEvent, passThroughData:Object):void {
                assertThat(_apiDocSelectionView.skin.currentState, equalTo("normal"));
            };
            Async.handleEvent(this, _apiDocSelectionView.skin, FlexEvent.STATE_CHANGE_COMPLETE, result);
        }

        private function selectRandomApiDoc():void { 
            const oldIndex:int = -1;
            const newIndex:int = int(Math.random() % 99) % _apiDocSelectionView.dropDownList.dataProvider.length;
            var indexChangeEvent:IndexChangeEvent = new IndexChangeEvent(IndexChangeEvent.CHANGE,
                    false, false, oldIndex, newIndex);
            _apiDocSelectionView.dropDownList.dispatchEvent(indexChangeEvent);
        }

        private function populateDropDownList():void {
            var apiDocList:ListCollectionView = new ArrayCollection();
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            apiDocList.addItem(new ApiDoc());
            _apiDocSelectionView.apiDocList = apiDocList;
        }
    }
}
