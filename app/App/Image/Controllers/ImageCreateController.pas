(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-img/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit ImageCreateController;

interface

uses

    Classes,
    fano;

type

    TImageCreateController = class(TRouteHandler, IDependency)
    private
        function generateJpegImage(const stream : TStream) : TStream;
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
     fpwritejpeg;


    function TImageCreateController.generateJpegImage(const stream : TStream) : TStream;
    var canvas : TFPCustomCanvas;
        image : TFPCustomImage;
        writer : TFPCustomImageWriter;
    begin
        { Create an image 100x100 pixels}
        image := TFPMemoryImage.Create(100, 100);

        { Attach the image to the canvas }
        canvas := TFPImageCanvas.create(image);

        { Create the writer }
        writer := TFPWriterJpeg.create;
        result := stream;
        try

          image.saveToStream (stream, writer);
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
            mem := generateJpegImage(mem);
            result := TBinaryResponse.create(
                response.headers(),
                'image/jpeg',
                str
            );
        finally
            str := nil;
        end;
    end;

end.
