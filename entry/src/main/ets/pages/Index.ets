import { ClubDetailViewModel } from '../viewmodel/ClubDetailViewModel';
import { HomeViewModel } from '../viewmodel/HomeViewModel';
import { RoundViewModel } from '../viewmodel/RoundViewModel';
import { ClubDetailView } from './ClubDetailView';
import { HomeView } from './HomeView';
import { RoundView } from './RoundView';
import { StarterView } from './StarterView';

@Entry
@Component
struct Index {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();
  @State homeVM: HomeViewModel = new HomeViewModel();
  @State clubDetailVM: ClubDetailViewModel = new ClubDetailViewModel();
  @State roundVM: RoundViewModel = new RoundViewModel();

  @Builder
  Pages(name: string) {
    if (name === 'StarterView') {
      StarterView();
    } else if (name === 'HomeView') {
      HomeView({ vm: this.homeVM })
    } else if (name === 'RoundView') {
      RoundView({ vm: this.roundVM });
    } else if (name === 'ClubDetailView') {
      ClubDetailView({ vm: this.clubDetailVM });
    }
  }

  build() {
    Navigation(this.pageStack)
      .mode(NavigationMode.Stack)
      .navDestination(this.Pages)
      .hideNavBar(true)
      .onAppear(() => {
        if (this.pageStack.getAllPathName().length === 0) {
          this.pageStack.pushPathByName('StarterView', null);
        }
      })
  }
}
