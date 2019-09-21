(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)

unit ImageCreateControllerFactory;

interface

uses

    fano;

type

    TImageCreateControllerFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    ImageCreateController;

    function TImageCreateControllerFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TImageCreateController.create();
    end;

end.
