(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit HomeViewFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view in home page
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    THomeViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils;

    function THomeViewFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := TTemplateView.create(
            extractFileDir(getCurrentDir()) + '/app/Templates/Home/index.html',
            container.get('templateParser') as ITemplateParser,
            container.get('fileReader') as IFileReader
        );
    end;
end.
