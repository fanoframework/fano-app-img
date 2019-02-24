(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)

unit HomeControllerFactory;

interface

uses

    fano;

type

    THomeControllerFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    HomeController;

    function THomeControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var routeMiddlewares : IMiddlewareCollectionAware;
    begin
        routeMiddlewares := container.get('routeMiddlewares') as IMiddlewareCollectionAware;
        try
            result := THomeController.create(
                routeMiddlewares.getBefore(),
                routeMiddlewares.getAfter(),
                container.get('homeView') as IView,
                container.get('viewParams') as IViewParameters
            );
        finally
            routeMiddlewares := nil;
        end;
    end;

end.
