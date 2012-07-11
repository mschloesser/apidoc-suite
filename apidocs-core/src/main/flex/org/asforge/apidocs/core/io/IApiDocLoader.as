/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/17/12
 * Time: 4:28 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.io {

    import flash.events.IEventDispatcher;

    import org.asforge.apidocs.core.parser.IApiDocParser;

    public interface IApiDocLoader extends IEventDispatcher {

        function get resourceLoader():IResourceLoader;
        function set resourceLoader(resourceLoader:IResourceLoader):void;
        
        function get resultParser():IApiDocParser;
        function set resultParser(resultParser:IApiDocParser):void;

        function load():void;
        
    }
}
