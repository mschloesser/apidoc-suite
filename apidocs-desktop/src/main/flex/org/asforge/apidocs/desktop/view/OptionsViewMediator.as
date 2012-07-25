/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/24/12
 * Time: 6:25 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.service.IApiDocService;
    import org.asforge.apidocs.desktop.model.OptionsModel;
    import org.asforge.apidocs.desktop.view.component.OptionsView;
    import org.robotlegs.mvcs.Mediator;

    public class OptionsViewMediator extends Mediator {

        [Inject]
        public var view:OptionsView;

        [Inject]
        public var apiDocService:IApiDocService;

        [Inject]
        public var model:OptionsModel;

        public function OptionsViewMediator() {
        }

        override public function onRegister():void {
            super.onRegister();
            view.saveApiDocSignal.add(saveApiDoc);
            view.deleteButtonSignal.add(deleteApiDoc);
            view.apiDocList = model.findAll();
        }

        private function deleteApiDoc(apiDoc:ApiDoc):void {
            model.deleteApiDoc(apiDoc);
        }

        private function saveApiDoc(apiDoc:ApiDoc):void {
            model.saveApiDoc(apiDoc);
        }
    }
}
