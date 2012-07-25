/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/10/12
 * Time: 7:33 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.dao {

    import flash.filesystem.File;

    import org.asforge.apidocs.core.dao.impl.SqlLiteApiDaoImpl;
    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.model.enumeration.ApiDocType;
    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;

    public class ApiDocDaoTestCase {

        private var apiDoc:ApiDoc;
        private var dao:IApiDocDao;

        [Before]
        public function setUp():void {
            apiDoc = makeTestDouble();
            var dbFile:File = File.applicationStorageDirectory
                .resolvePath("apidocs.sqlite");
            dao = new SqlLiteApiDaoImpl(dbFile);
        }

        [After]
        public function tearDown():void {
            dao = null;
            apiDoc = null;
            var dbFile:File = File.applicationStorageDirectory
                .resolvePath("apidocs-integration-test.sqlite");
            if (dbFile.exists) {
                dbFile.deleteFile();
            }
        }

        [Test]
        public function addApiDoc():void {
            assertThat(apiDoc.id, equalTo(0));
            dao.addApiDoc(apiDoc);
            assertThat(apiDoc.id, greaterThan(0));
        }

        [Test]
        public function findAll():void {
            assertThat(dao.findAll().length, greaterThan(0));
        }

        [Test]
        public function updateApiDoc():void {
            apiDoc.title = "foo";
            dao.updateApiDoc(apiDoc);
        }

        [Test]
        public function deleteApiDoc():void {
            dao.deleteApiDoc(apiDoc);
        }

        private function makeTestDouble():ApiDoc {
            var apiDoc:ApiDoc = new ApiDoc();
            apiDoc.title = "Test API Doc";
            apiDoc.url = "http://www.apidoc-test.com/all-classes.html";
            apiDoc.type = ApiDocType.AS3.ordinal();
            return apiDoc;
        }
    }
}
