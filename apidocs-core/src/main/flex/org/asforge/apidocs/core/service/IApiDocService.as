/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 8:49 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;

    public interface IApiDocService {
        function findAll():ListCollectionView;

        function addApiDoc(apiDoc:ApiDoc):void;

        function deleteApiDoc(apiDoc:ApiDoc):void;

        function updateApiDoc(apiDoc:ApiDoc):void;
    }
}
