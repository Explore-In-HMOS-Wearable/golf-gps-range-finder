import { RoundViewModel } from '../viewmodel/RoundViewModel';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ColorMetrics
} from '@kit.ArkUI';

@Component
export struct RoundView {
  @ObjectLink public vm: RoundViewModel;
  private swiperCtrl: SwiperController = new SwiperController();
  private backButtonOptions: ArcButtonOptions = new ArcButtonOptions({});
  @Consume('pageStack') pageStack: NavPathStack;

  aboutToAppear() {
    this.backButtonOptions = new ArcButtonOptions({
      label: 'Next Hole',
      fontColor: ColorMetrics.resourceColor('#205375'),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor('#EFEFEF'),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE,
      onClick: () => {
        if (this.vm.currentHole < this.vm.totalHoles) {
          this.vm.nextHole()
        }
      },
    });
  }

  build() {
    NavDestination() {
      Column() {
        Swiper(this.swiperCtrl) {

          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text(`Hole ${this.vm.currentHole}`)
              .fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
              .margin({ bottom: 12 })

            Row({ space: 18 }) {
              Button('-', { type: ButtonType.Capsule })
                .fontSize(20)
                .fontColor('#FFFFFF')
                .backgroundColor('#D9534F')
                .width(48)
                .height(36)
                .onClick(() => {
                  if (this.vm.strokes > 0) {
                    this.vm.strokes--
                  }
                })

              Text(`${this.vm.strokes}`)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .width(40)
                .textAlign(TextAlign.Center)

              Button('+', { type: ButtonType.Capsule })
                .fontSize(20)
                .fontColor('#FFFFFF')
                .backgroundColor('#5CB85C')
                .width(48)
                .height(36)
                .onClick(() => {
                  this.vm.strokes++
                })
            }
            .margin({ top: 16, bottom: 16 })

            Text(`Stroke`)
              .fontSize(13).fontColor('#AAAAFF')
              .margin({ bottom: 6 })
          }

          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text('Hole Info')
              .fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
              .margin({ bottom: 12 })

            Text(`Distance: ${this.vm.currentHoleDistance} m`)
              .fontSize(13).fontColor('#FFD700')
              .margin({ bottom: 6 })

            Text(`Par: ${this.vm.currentHolePar}`)
              .fontSize(13).fontColor('#AAAAFF')
              .margin({ bottom: 6 })

            Text(`Avg Stroke: ${this.vm.currentHoleAverageStroke}`)
              .fontSize(13).fontColor('#00FFAA')
          }

          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text('Hole Direction')
              .fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
              .margin({ bottom: 10 })

            Image($r('app.media.arrow'))
              .width(48).height(48)
              .rotate({ angle: this.vm.currentHoleBearing })
              .margin({ bottom: 6 })

            Text(`${this.vm.currentHoleDirection} (${Math.round(this.vm.currentHoleBearing)}°)`)
              .fontSize(13).fontColor('#CCCCCC')
          }
        }
        .loop(false)
        .width('100%')
        .height('78%')
        .backgroundColor('#112B3C')

        ArcButton({ options: this.backButtonOptions })
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
