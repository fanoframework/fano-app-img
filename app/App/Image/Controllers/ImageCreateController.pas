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
    TImageCreateController = class(TAbstractController)
    private
        procedure getImageResolution(
            const args : IRouteArgsReader;
            out width: integer;
            out height:integer
        );
        function generatePngImage(
            const stream : TStream;
            const width : integer;
            const height : integer
        ) : TStream;
    public
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses sysutils,
     fpimage,
     fpcanvas,
     fpimgcanv,
     fpwritepng;

    procedure TImageCreateController.getImageResolution(
        const args : IRouteArgsReader;
        out width: integer;
        out height:integer
    );
    var wPlaceholder : TPlaceholder;
        hPlaceholder : TPlaceholder;
    begin
        (*!------------------------------------
         * get single route argument
         * for route pattern /image/{width}x{height}.png
         * and actual url /image/200x100.png
         * placeHolder will contains
         * { name : 'width', value : '200'}
         * { name : 'height', value : '100'}
         *--------------------------------------*)
        wPlaceholder := args.getArg('width');
        hPlaceholder := args.getArg('height');
        width := strtoInt(wPlaceholder.value);
        height := strtoInt(hPlaceholder.value);
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
        borderCol: TFPColor;
        bgCol :TFPColor;
    begin
        randomize();
        //generate random color
        bgCol.red := random(65535);
        bgCol.green := random(65535);
        bgCol.blue := random(65535);
        bgCol.alpha := 65535;
        borderCol.red := random(65535);
        borderCol.green := random(65535);
        borderCol.blue := random(65535);
        borderCol.alpha := 65535;

        { Create an image width x height pixels}
        image := TFPMemoryImage.Create(width, height);
        try
            { Attach the image to the canvas }
            canvas := TFPImageCanvas.create(image);
            try
                { Create the writer }
                writer := TFPWriterPng.create;
                try
                    { Set the pen styles }
                    with canvas do
                    begin
                        brush.FPColor:= bgCol;
                        brush.Style := bsSolid;
                        pen.mode    := pmCopy;
                        pen.style   := psSolid;
                        pen.width   := 2;
                        pen.FPColor := borderCol;
                    end;
                    canvas.Ellipse (10,10, image.width-10,image.height-10);
                    image.saveToStream(stream, writer);
                    result := stream;
                finally
                    writer.Free;
                end;
            finally
                canvas.Free;
            end;
        finally
            image.Free;
        end;
    end;

    function TImageCreateController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var mem : TStream;
        w,h : integer;
    begin
        getImageResolution(args, w, h);
        mem := TMemoryStream.create();
        try
            mem := generatePngImage(
                mem,
                w,
                h
            );
            result := TBinaryResponse.create(
                response.headers(),
                'image/png',
                TResponseStream.create(mem)
            );
        finally
            //no need to call mem.free() as this
            //will be done by response stream
            mem := nil;
        end;
    end;

end.
