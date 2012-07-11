/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/17/12
 * Time: 4:50 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.io {

    import flash.events.IEventDispatcher;

    public interface IResourceLoader extends IEventDispatcher {

        function set sourceUrl(sourceUrl:String):void;

        function load():void;
    }
}
