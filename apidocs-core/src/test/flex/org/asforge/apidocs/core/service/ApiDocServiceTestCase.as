/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 8:39 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.service {

    import mockolate.mock;
    import mockolate.runner.MockolateRule;

    import mx.collections.ArrayCollection;

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;

    public class ApiDocServiceTestCase {

        [Rule]
        public var mockolateRule:MockolateRule = new MockolateRule();

        [Mock]
        public var apiDocDao:IApiDocDao;

        private var service:IApiDocService;

        [Before]
        public function setUp():void {
            service = new ApiDocServiceImpl(apiDocDao);
        }

        [Test]
        public function emptyDatabaseReturnsEmptyList():void {
            mock(apiDocDao).method("findAll").returns(new ArrayCollection());
            assertThat(service.findAll().length, equalTo(0));
        }

        [Test]
        public function findAllApiDocs():void {
            mock(apiDocDao).method("findAll").returns(new ArrayCollection([ new ApiDoc()]));
            assertThat(service.findAll().length, greaterThan(0));
        }

        [Test]
        public function addApiDoc():void {
            var apiDoc:ApiDoc = new ApiDoc();
            mock(apiDocDao).method("addApiDoc").args(apiDoc).calls(function():void {
                apiDoc.id = 1;
            }).once();
            service.addApiDoc(apiDoc);
            assertThat(apiDoc.id, greaterThan(0));
        }
    }
}
