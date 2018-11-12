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

    TImageCreateController = class(TRouteHandler, IDependency)
    private
        function generatePngImage(const stream : TStream) : TStream;
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


    function TImageCreateController.generatePngImage(const stream : TStream) : TStream;
    var canvas : TFPCustomCanvas;
        image : TFPCustomImage;
        writer : TFPCustomImageWriter;
        passionRed: TFPColor = (Red: 65535; Green: 0; Blue: 0; Alpha: 65535);
    begin
        { Create an image 300x300 pixels}
        image := TFPMemoryImage.Create(300, 300);

        { Attach the image to the canvas }
        canvas := TFPImageCanvas.create(image);
        { Create the writer }
        writer := TFPWriterPng.create;
        try

          { Set the pen styles }
          with canvas do
          begin
              pen.mode    := pmCopy;
              pen.style   := psSolid;
              pen.width   := 1;
              pen.FPColor := passionRed;
          end;
          { Draw a circle }
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
    begin
        mem := TMemoryStream.create();
        str := TResponseStream.create(mem);
        try
            mem := generatePngImage(mem);
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
