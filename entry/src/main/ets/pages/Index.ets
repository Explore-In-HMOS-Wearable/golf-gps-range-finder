import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics } from '@kit.ArkUI';
import { routePageNoParams } from '../util/NavgiationHelper';

@Entry
@Component
struct Index {
  @State message: string = 'GolfGPSFinder';
  bottomOptions: ArcButtonOptions = new ArcButtonOptions({})
  aboutToAppear() {
    this.bottomOptions = new ArcButtonOptions({
      label: 'Start',
      fontColor: ColorMetrics.resourceColor('#205375'),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor('#EFEFEF'),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE,
      onClick: () => {
        routePageNoParams('pages/HomeView');
      }
    });
  }
  build() {
    Flex({justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      direction: FlexDirection.Column}){
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold).margin({bottom:10 , top: 30})
      Image($r('app.media.golf'))
        .width('32%')
      ArcButton({ options: this.bottomOptions }).margin({top: 40})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#112B3C')
  }
}