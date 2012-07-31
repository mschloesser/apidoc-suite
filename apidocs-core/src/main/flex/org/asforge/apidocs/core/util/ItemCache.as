/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/27/12
 * Time: 5:17 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.util {

    import flash.utils.Dictionary;

    import mx.collections.IList;

    public class ItemCache {

        public var storage:Dictionary;

        private var _size:int = 0;

        public function ItemCache() {
            storage = new Dictionary();
        }

        public function add(key:int, items:IList):void {
            storage[key] = items;
            _size++;
        }

        public function get size():int {
            return _size;
        }

        public function contains(id:int):Boolean {
            return storage[id] != null && storage[id] != undefined;
        }

        public function retrieve(id:int):IList {
            return storage[id];
        }
    }
}
