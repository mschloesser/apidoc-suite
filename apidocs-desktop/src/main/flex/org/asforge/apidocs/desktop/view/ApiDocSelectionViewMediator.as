/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.robotlegs.mvcs.Mediator;

    public class ApiDocSelectionViewMediator extends Mediator {

        [Inject]
        public var view:IApiDocSelectionView;

        [Inject]
        public var model:ApiDocModel;

        [Inject]
        public var apiDocSelectedSignal:ApiDocSelectedSignal;

        override public function onRegister():void {
            view.apiDocList = model.findAll();
            view.apiDocSelected.add(onApiDocSelected);
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            apiDocSelectedSignal.dispatch(apiDoc);
        }
    }
}
