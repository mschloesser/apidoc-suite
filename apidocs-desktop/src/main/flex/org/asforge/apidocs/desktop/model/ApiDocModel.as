/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 6:03 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.model {

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.service.IApiDocService;
    import org.robotlegs.mvcs.Actor;

    public class ApiDocModel extends Actor {

        [Inject]
        public var apiDocService:IApiDocService;

        public function findAll():ListCollectionView {
            return apiDocService.findAll();
        }
    }
}
