/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/27/12
 * Time: 5:16 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.util {

    import flash.utils.Dictionary;

    import mockolate.runner.MockolateRule;

    import mx.collections.IList;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isTrue;

    public class ItemCacheTestCase {

        [Rule]
        public var rule:MockolateRule = new MockolateRule();

        [Mock]
        public var items:IList;

        public var apiDoc:ApiDoc;
        public var dictionary:Dictionary;

        public var cache:ItemCache;

        [Before]
        public function setUp():void {
            apiDoc = new ApiDoc();
            apiDoc.id = 1;
            apiDoc.title = "a";

            dictionary = new Dictionary();

            cache = new ItemCache();
            cache.storage = dictionary;
        }

        [After]
        public function tearDown():void {
            for (var key:String in dictionary) {
                delete dictionary[key];
            }
            dictionary = null;
            apiDoc = null;
            cache = null;
        }

        [Test]
        public function cacheItem():void {
            assertThat(cache.size, equalTo(0));
            cache.add(apiDoc.id, items);
            assertThat(cache.size, equalTo(1));
        }

        [Test]
        public function contains():void {
            dictionary[apiDoc.id] = items;
            assertThat(cache.contains(apiDoc.id), isTrue());
        }

        [Test]
        public function doesNotContain():void {
            assertThat(cache.contains(apiDoc.id), isFalse());
        }

        [Test]
        public function retrieve():void {
            dictionary[apiDoc.id] = items;
            assertThat(cache.retrieve(apiDoc.id), equalTo(items));
        }
    }
}
