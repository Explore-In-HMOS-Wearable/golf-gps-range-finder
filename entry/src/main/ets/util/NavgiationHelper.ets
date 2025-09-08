import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

export function routePageNoParams(url: string) {
  let options: router.RouterOptions = {
    url: url,
  }
  try {
    router.pushUrl(options, router.RouterMode.Single)
  } catch (err) {
    console.info(` fail callback, code: ${(err as BusinessError).code}, msg: ${(err as BusinessError).message}`)
  }
}

export function routePageWithParams(url: string, param1: string) {
  let options: router.RouterOptions = {
    url: url,
    params: param1
  }
  try {
    router.pushUrl(options, router.RouterMode.Single)
  } catch (err) {
    console.info(` fail callback, code: ${(err as BusinessError).code}, msg: ${(err as BusinessError).message}`)
  }
}

export function routePageWithObjectParams(url: string, params: object) {
  let options: router.RouterOptions = {
    url: url,
    params: params
  }
  try {
    router.pushUrl(options, router.RouterMode.Single)
  } catch (err) {
    console.info(` fail callback, code: ${(err as BusinessError).code}, msg: ${(err as BusinessError).message}`)
  }
}

export function getParams() {
  let params: object = router.getParams()
  try {
    return params
  } catch (err) {
    console.info(` fail callback, code: ${(err as BusinessError).code}, msg: ${(err as BusinessError).message}`)
    return undefined
  }
}

export function clearBackstack() {
  router.clear()
}

export function routerBack() {
  router.back()
}