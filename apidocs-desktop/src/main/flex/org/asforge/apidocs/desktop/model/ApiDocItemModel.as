/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 5:55 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.model {

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;

    public class ApiDocItemModel {

        [Inject]
        public var apiDocSelected:ApiDocSelectedSignal;

        public function ApiDocItemModel() {
            apiDocSelected.add(onApiDocSelected);
        }

        private function onApiDocSelected(apiDoc:ApiDoc):void {
            
        }
    }
}
