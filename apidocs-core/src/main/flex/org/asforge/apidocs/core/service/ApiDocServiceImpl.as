/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 8:49 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.asforge.apidocs.core.model.entity.ApiDoc;

    public class ApiDocServiceImpl implements IApiDocService {

        private var _dao:IApiDocDao;

        public function ApiDocServiceImpl(apiDocDao:IApiDocDao) {
            _dao = apiDocDao;
        }

        public function findAll():ListCollectionView {
            return _dao.findAll();
        }

        public function addApiDoc(apiDoc:ApiDoc):void {
            _dao.addApiDoc(apiDoc);
        }

        public function deleteApiDoc(apiDoc:ApiDoc):void {
            _dao.deleteApiDoc(apiDoc);
        }

        public function updateApiDoc(apiDoc:ApiDoc):void {
            _dao.updateApiDoc(apiDoc);
        }
    }
}
