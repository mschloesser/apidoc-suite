/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 5:28 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;

    import org.osflash.signals.ISignal;

    public interface IApiDocSelectionView {
        function get apiDocList():ListCollectionView;
        function set apiDocList(value:ListCollectionView):void;

        function get apiDocSelected():ISignal

        function set state(state:String):void;
    }
}
