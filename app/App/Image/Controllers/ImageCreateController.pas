(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit ImageCreateController;

interface

{$MODE OBJFPC}
{$H+}

uses

    Classes,
    fano;

type

    (*!------------------------------------------------------------
     * Controller that handle PNG image generation
     *-------------------------------------------------------------
     * Route /image/{width}x{height}.png
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------------------- *)
    TImageCreateController = class(TRouteHandler, IDependency)
    private
        procedure getImageResolution(out width: integer; out height:integer);
        function generatePngImage(
            const stream : TStream;
            const width : integer;
            const height : integer
        ) : TStream;
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; override;
    end;

implementation

uses sysutils,
     fpimage,
     fpcanvas,
     fpimgcanv,
     fpwritepng;

    procedure TImageCreateController.getImageResolution(out width: integer; out height:integer);
    var wPlaceholder : TPlaceholder;
        hPlaceholder : TPlaceholder;
    begin
        (*!------------------------------------
         * get single route argument
         * for route pattern /image/{width}x{height}.png
         * and actual url /image/200x100.png
         * placeHolder will contains
         * { phName : 'width', phValue : '200'}
         * { phName : 'height', phValue : '100'}
         *--------------------------------------*)
        wPlaceholder := getArg('width');
        hPlaceholder := getArg('height');
        width := strtoInt(wPlaceholder.phValue);
        height := strtoInt(hPlaceholder.phValue);
        if (width < 10) then
        begin
            width := 10;
        end;
        if (height < 10) then
        begin
            height := 10;
        end;
        if (width > 300) then
        begin
            width := 300;
        end;
        if (height > 300) then
        begin
            height := 300;
        end;
    end;

    (*!------------------------------------
     * generate PNG image
     *--------------------------------------
     * @credit http://wiki.freepascal.org/fcl-image
     *--------------------------------------*)
    function TImageCreateController.generatePngImage(
        const stream : TStream;
        const width : integer;
        const height : integer
    ) : TStream;
    var canvas : TFPCustomCanvas;
        image : TFPCustomImage;
        writer : TFPCustomImageWriter;
        passionRed: TFPColor = (Red: 65535; Green: 0; Blue: 0; Alpha: 65535);
    begin
        { Create an image width x height pixels}
        image := TFPMemoryImage.Create(width, height);

        { Attach the image to the canvas }
        canvas := TFPImageCanvas.create(image);
        { Create the writer }
        writer := TFPWriterPng.create;
        try
            { Set the pen styles }
            with canvas do
            begin
                brush.FPColor:= colBlue;
                brush.Style := bsSolid;
                pen.mode    := pmCopy;
                pen.style   := psSolid;
                pen.width   := 2;
                pen.FPColor := passionRed;
            end;
            canvas.Ellipse (10,10, image.width-10,image.height-10);
            image.saveToStream(stream, writer);
            result := stream;
        finally
            canvas.Free;
            image.Free;
            writer.Free;
        end;
    end;

    function TImageCreateController.handleRequest(
          const request : IRequest;
          const response : IResponse
    ) : IResponse;
    var str : IResponseStream;
        mem : TStream;
        w,h : integer;
    begin
        getImageResolution(w, h);
        mem := TMemoryStream.create();
        str := TResponseStream.create(mem);
        try
            mem := generatePngImage(
                mem,
                w,
                h
            );
            result := TBinaryResponse.create(
                response.headers(),
                'image/png',
                str
            );
        finally
            str := nil;
        end;
    end;

end.
