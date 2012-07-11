/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/10/12
 * Time: 7:35 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.dao {

    import mx.collections.ICollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;

    public interface ApiDocDao {
        function addApiDoc(apiDoc:ApiDoc):void;
        function deleteApiDoc(apiDoc:ApiDoc):void;
        function updateApiDoc(apiDoc:ApiDoc):void;
        function findAll():ICollectionView;
    }
}
