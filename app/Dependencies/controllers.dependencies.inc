(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-img
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-api/blob/master/LICENSE (GPL 2.0)
 *------------------------------------------------------------- *)

{-----------------------------------------------
  register ImageCreateController inside
  dependency container
------------------------------------------------}
container.add('imageCreateController', TImageCreateControllerFactory.create());

{-----------------------------------------------
  register HomeController inside
  dependency container
------------------------------------------------}
container.add('homeController', THomeControllerFactory.create());
