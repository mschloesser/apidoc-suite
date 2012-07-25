/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/24/12
 * Time: 7:27 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.controller {

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.robotlegs.mvcs.SignalCommand;

    public class AddApiDocToListCommand extends SignalCommand {

        [Inject]
        public var apiDocDao:IApiDocDao;

        public function AddApiDocToListCommand() {

            trace("edewde");

            var a:int = 0;

        }
    }
}
