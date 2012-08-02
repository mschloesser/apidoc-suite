/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/7/12
 * Time: 11:38 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;

    import org.osflash.signals.ISignal;

    public interface IApiDocItemListView {
        function get apiDocItemList():ListCollectionView;
        function set apiDocItemList(value:ListCollectionView):void;

        function get itemSelected():ISignal;

        function set state(state:String):void;
    }
}
