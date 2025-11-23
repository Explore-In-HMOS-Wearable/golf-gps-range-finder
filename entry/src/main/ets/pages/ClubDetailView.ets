import { ClubDetailViewModel } from '../viewmodel/ClubDetailViewModel';
import { GolfClub } from '../model/GolfClub';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonStatus,
  ArcButtonStyleMode,
  ArcButtonPosition,
  ColorMetrics
} from '@kit.ArkUI';

@Component
export struct ClubDetailView {
  @ObjectLink public vm: ClubDetailViewModel;
  private swiperCtrl: SwiperController = new SwiperController();
  @State private currentPageIndex: number = 0;
  @Consume('pageStack') pageStack: NavPathStack;
  startRoundOptions: ArcButtonOptions = new ArcButtonOptions({})

  aboutToAppear() {
    this.startRoundOptions = new ArcButtonOptions({
      label: '⛳ Start Round',
      fontColor: ColorMetrics.resourceColor('#FFFFFF'),
      status: ArcButtonStatus.NORMAL,
      backgroundColor: ColorMetrics.resourceColor('#4CAF50'),
      styleMode: ArcButtonStyleMode.CUSTOM,
      position: ArcButtonPosition.BOTTOM_EDGE,
      onClick: () => this.pageStack.pushPathByName('RoundView', null)
    });
  }

  build() {
    NavDestination() {
      Column() {
        Swiper(this.swiperCtrl) {
          // 1 Club Info
          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text('Club Info')
              .fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').margin({ bottom: 12 })

            Column({ space: 10 }) {
              InfoRow({ label: 'Name', value: this.vm.club.name })
              InfoRow({ label: 'Rating', value: `${this.vm.club.rating.toFixed(1)} / 5` })
              InfoRow({ label: 'Distance', value: `${this.vm.club.distance.toFixed(1)} km` })
            }
            .backgroundColor('#1C3B57')
            .borderRadius(16)
            .width('85%')
            .padding({
              top: 14,
              bottom: 14,
              left: 16,
              right: 16
            })
          }
          .width('100%')
          .height('100%')

          // 2 Contact Info
          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text('Contact Info')
              .fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').margin({ bottom: 12 })

            Column({ space: 10 }) {
              InfoRow({ label: 'Address', value: this.vm.club.address })
              InfoRow({ label: 'Phone', value: this.vm.club.phone })
              InfoRow({ label: 'Website', value: 'golfclub.com' })
            }
            .backgroundColor('#1C3B57')
            .borderRadius(16)
            .width('85%')
            .padding({
              top: 14,
              bottom: 14,
              left: 16,
              right: 16
            })
          }
          .width('100%')
          .height('100%')


          // 3 Course Info
          Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
            Text('Course Info')
              .fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').margin({ bottom: 12 })

            Column({ space: 10 }) {
              InfoRow({ label: 'Holes', value: `${this.vm.club.holes}` })
              InfoRow({ label: 'Par', value: `${this.vm.club.par}` })
              InfoRow({ label: 'Grass', value: 'Bermuda' })
            }
            .backgroundColor('#1C3B57')
            .borderRadius(16)
            .width('85%')
            .padding({
              top: 14,
              bottom: 14,
              left: 16,
              right: 16
            })
          }
          .width('100%')
          .height('100%')
        }
        .onChange((index: number) => {
          this.currentPageIndex = index
        }
        )
        .loop(false)
        .width('100%')
        .height('78%')

        ArcButton({ options: this.startRoundOptions })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#112B3C')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
      const params = ctx.pathInfo.param as GolfClub;
      if (params) {
        this.vm.setClub(params as GolfClub);
      }
    })
    .hideBackButton(true)
  }
}

@Component
export struct InfoRow {
  @Prop label: string;
  @Prop value: string;

  build() {
    Row() {
      Text(`${this.label}:`)
        .fontSize(13)
        .fontColor('#AAAAAA')

      Blank().width(1)

      Text(this.value)
        .fontSize(13)
        .fontColor('#FFFFFF')
        .maxLines(1)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
    }
    .justifyContent(FlexAlign.Start)
    .width('100#')
  }
}
