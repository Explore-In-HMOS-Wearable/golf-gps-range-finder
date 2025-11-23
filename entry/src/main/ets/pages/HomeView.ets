import { GolfClub } from '../model/GolfClub';
import { HomeViewModel } from '../viewmodel/HomeViewModel';
import { ArcList, ArcListItem, UIContext, ComponentContent } from '@kit.ArkUI';

@Builder
function header() {
  Column() {
    Text('Nearby Golf Clubs')
      .fontSize('40px')
      .fontWeight(FontWeight.Bold)
      .fontColor('#FFFFFF')
  }
  .margin({ top: 16, bottom: 16 })
  .align(Alignment.Center)
}

@Component
export struct HomeView {
  @ObjectLink public vm: HomeViewModel;
  context: UIContext = this.getUIContext()
  tabBar1: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(header));
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        if (this.vm.isLoading) {
          // Loading state
          Column() {
            Text('Loading nearby clubs...')
              .fontSize(14)
              .fontColor('#AAAAAA')
              .align(Alignment.Center)
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        } else if (this.vm.clubs.length === 0) {
          // Empty state
          Column() {
            Text('No golf clubs found nearby')
              .fontSize(14)
              .fontColor('#BBBBBB')
              .align(Alignment.Center)
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        } else {
          // ArcList with clubs
          ArcList({ header: this.tabBar1 }) {
            ForEach(this.vm.clubs, (club: GolfClub, index: number) => {
              ArcListItem() {
                Row() {
                  Column({ space: 4 }) {
                    Text(club.name)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .width('80%')
                      .textAlign(TextAlign.Start)
                      .fontSize(16)
                      .fontColor('#FFFFFF')

                    Text(`${club.distance.toFixed(1)} km away`)
                      .fontSize(12)
                      .fontColor('#CCCCCC')
                  }
                }
                .justifyContent(FlexAlign.Center)
                .backgroundColor('#205375')
                .borderRadius(20)
                .margin(5)
                .width('85%')
                .padding({
                  top: 6,
                  bottom: 6,
                  left: 10,
                  right: 8
                })
                .onClick(() => {
                  this.pageStack.pushPathByName('ClubDetailView', club);
                });
              }
            }, (item: string, index: number) => item)
          }
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#112B3C')
      .alignItems(HorizontalAlign.Center)
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }
}
