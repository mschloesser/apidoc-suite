/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/17/12
 * Time: 4:33 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import mx.collections.IList;

    public interface IApiDocParser {
        function parseApiDoc(source:String):IList;
    }
}
