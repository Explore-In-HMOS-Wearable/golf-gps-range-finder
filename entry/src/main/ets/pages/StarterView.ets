import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics
} from '@kit.ArkUI';

@Component
export struct StarterView {
  @Consume('pageStack') pageStack: NavPathStack;
  message: string = 'GolfGPSFinder';
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
        this.pageStack.pushPathByName('HomeView', null);
      }
    });
  }

  build() {
    NavDestination() {
      Flex({
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center,
        direction: FlexDirection.Column
      }) {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold).margin({ bottom: 10, top: 30 })
        Image($r('app.media.golf'))
          .width('32%')
        ArcButton({ options: this.bottomOptions }).margin({ top: 40 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#112B3C')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }
}