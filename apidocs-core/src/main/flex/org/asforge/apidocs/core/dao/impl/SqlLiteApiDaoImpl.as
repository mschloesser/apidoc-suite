/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/10/12
 * Time: 7:36 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.dao.impl {

    import flash.data.SQLConnection;
    import flash.filesystem.File;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;

    import nz.co.codec.flexorm.EntityManager;

    import org.asforge.apidocs.core.dao.*;
    import org.asforge.apidocs.core.model.entity.ApiDoc;

    public class SqlLiteApiDaoImpl implements IApiDocDao {

        private var _em:EntityManager;
        private var _sqlConnection:SQLConnection;

        public function SqlLiteApiDaoImpl(dbFile:File) {
            _em = EntityManager.instance;
            _sqlConnection = new SQLConnection();
            _sqlConnection.open(dbFile);
            _em.sqlConnection = _sqlConnection;
        }

        public function addApiDoc(apiDoc:ApiDoc):void {
            _em.save(apiDoc);
        }

        public function deleteApiDoc(apiDoc:ApiDoc):void {
            _em.remove(apiDoc);
        }

        public function updateApiDoc(apiDoc:ApiDoc):void {
            _em.save(apiDoc);
        }

        public function findAll():ListCollectionView {
            var a:ArrayCollection = _em.findAll(ApiDoc);
            return a;
        }
    }
}
