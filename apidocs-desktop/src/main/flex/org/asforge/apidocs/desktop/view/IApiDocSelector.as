/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 5:28 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.IList;

    public interface IApiDocSelector {
        function get apiDocList():IList;
        function set apiDocList(value:IList):void;
    }
}
