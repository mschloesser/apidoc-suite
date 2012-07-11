/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/17/12
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.io {

    import flash.events.Event;

    public class ResourceLoaderEvent extends Event {

        public static const RESULT:String = "resourceLoaderResult";

        private var _data:Object;

        public function ResourceLoaderEvent(type:String, bubbles:Boolean = false,
                cancable:Boolean = false, data:Object = null)
        {
            super(type, bubbles, cancable);
            _data = data;
        }

        public function get data():Object {
            return _data;
        }
    }
}
