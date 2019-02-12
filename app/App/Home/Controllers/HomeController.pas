(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit HomeController;

interface

{$MODE OBJFPC}
{$H+}

uses

    Classes,
    fano;

type

    (*!------------------------------------------------------------
     * Controller for home page
     *-------------------------------------------------------------
     * Route /
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------------------- *)
    THomeController = class(TRouteHandler, IDependency)
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

    function THomeController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    var bodyInst : IResponseStream;
    begin
        bodyInst := response.body();
        bodyInst.write('<html>');
        bodyInst.write('<head><title>Fano Framework PNG Image Generator</title>');
        bodyInst.write('</head>');
        bodyInst.write('<body>');
        bodyInst.write('<div>Image below is generated on the fly and change color randomly everytime this page is refresh.</div>');
        bodyInst.write('<img src="/image/200x200.png" alt="Random color image">');
        bodyInst.write('<div><a href="https://fanoframework.github.io">Documentation</a> <a href="https://github.com/fanoframework/fano-app-img">View Source</a></div>');
        bodyInst.write('</body>');
        bodyInst.write('</html>');
        result := response;
    end;

end.
