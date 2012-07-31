/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 6:00 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.signal {

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.osflash.signals.Signal;

    public class ApiDocSelectedSignal extends Signal {

        public function ApiDocSelectedSignal() {
            super(ApiDoc);
        }
    }
}
