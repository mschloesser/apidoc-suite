/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:51 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.app {

    import flash.filesystem.File;
    import flash.net.URLLoader;
    import flash.utils.Dictionary;

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.asforge.apidocs.core.dao.impl.SqlLiteApiDaoImpl;
    import org.asforge.apidocs.core.parser.As3DocParser;
    import org.asforge.apidocs.core.parser.As3SourceItemExtractor;
    import org.asforge.apidocs.core.parser.IApiDocParser;
    import org.asforge.apidocs.core.service.ApiDocItemService;
    import org.asforge.apidocs.core.service.ApiDocServiceImpl;
    import org.asforge.apidocs.core.service.IApiDocItemService;
    import org.asforge.apidocs.core.service.IApiDocService;
    import org.asforge.apidocs.core.util.ItemCache;
    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.asforge.apidocs.desktop.model.OptionsModel;
    import org.asforge.apidocs.desktop.signal.ApiDocSelectedSignal;
    import org.asforge.apidocs.desktop.view.ApiDocItemListViewMediator;
    import org.asforge.apidocs.desktop.view.ApiDocSelectionViewMediator;
    import org.asforge.apidocs.desktop.view.FilterViewMediator;
    import org.asforge.apidocs.desktop.view.IApiDocItemListView;
    import org.asforge.apidocs.desktop.view.IApiDocSelectionView;
    import org.asforge.apidocs.desktop.view.IOptionsView;
    import org.asforge.apidocs.desktop.view.OptionsViewMediator;
    import org.asforge.apidocs.desktop.view.component.ApiDocItemListView;
    import org.asforge.apidocs.desktop.view.component.DropDownListApiDocSelectionView;
    import org.asforge.apidocs.desktop.view.component.ListFilterView;
    import org.asforge.apidocs.desktop.view.component.OptionsView;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.SignalContext;

    public class ApplicationContext extends SignalContext {

        override public function startup():void {
            
            var dbFile:File = File.applicationStorageDirectory.resolvePath("foo.sqlite");
            injector.mapValue(File, dbFile);
            injector.mapSingletonOf(IApiDocDao, SqlLiteApiDaoImpl);
//            injector.mapSingletonOf(IApiDocDao, InMemoryApiDaoImpl);
            injector.mapSingletonOf(IApiDocService, ApiDocServiceImpl);
            injector.mapSingletonOf(IApiDocParser, As3DocParser);

            injector.mapSingleton(ApiDocSelectedSignal);


            var successSignal:ISignal = new Signal(ListCollectionView);
            var errorSignal:ISignal = new Signal();

            var itemService:ApiDocItemService = new ApiDocItemService(successSignal, errorSignal);
            itemService.itemCache = new ItemCache();
            itemService.itemCache.storage = new Dictionary();
            itemService.loader = new URLLoader();

            var as3DocParser:As3DocParser = new As3DocParser();
            as3DocParser.apiDocItemExtractor = new As3SourceItemExtractor();
            itemService.parser = as3DocParser;
            injector.mapValue(IApiDocItemService, itemService);

            injector.mapSingleton(ApiDocModel);
            injector.mapSingleton(ApiDocItemModel);
            injector.mapSingleton(OptionsModel);

            mediatorMap.mapView(DropDownListApiDocSelectionView, ApiDocSelectionViewMediator, IApiDocSelectionView);
            mediatorMap.mapView(ApiDocItemListView, ApiDocItemListViewMediator, IApiDocItemListView);
            mediatorMap.mapView(ListFilterView, FilterViewMediator);
            mediatorMap.mapView(OptionsView, OptionsViewMediator, IOptionsView);

            super.startup();
        }
    }
}
