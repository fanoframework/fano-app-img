(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-api/blob/master/LICENSE (GPL 2.0)
 *------------------------------------------------------------- *)

{-----------------------------------------------
setup html template parser,
we do not use any template variable, so just
use null implementation
------------------------------------------------}
container.add('templateParser', TNullTemplateParserFactory.create());

{-----------------------------------------------
setup file reader
------------------------------------------------}
container.add('fileReader', TStringFileReaderFactory.create());

{-----------------------------------------------
  register view parameters instance
  we do not use any view parameters so just pass
  null implementation
------------------------------------------------}
container.add('viewParams', TNullViewParametersFactory.create());

{-----------------------------------------------
  register view for home
------------------------------------------------}
container.add('homeView', THomeViewFactory.create());
