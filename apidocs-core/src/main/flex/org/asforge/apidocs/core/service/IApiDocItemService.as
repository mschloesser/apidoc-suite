/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/29/12
 * Time: 1:39 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.osflash.signals.ISignal;

    public interface IApiDocItemService {
        function queryItems(apiDoc:ApiDoc):void;

        function get itemsFound():ISignal;

        function get errorOccurred():ISignal;
    }
}
