/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.robotlegs.mvcs.Mediator;

    public class ApiDocSelectionViewMediator extends Mediator {

        [Inject]
        public var view:IApiDocSelectionView;

        [Inject]
        public var model:ApiDocModel;

        override public function onRegister():void {
            view.apiDocList = model.findAll();
        }
    }
}
