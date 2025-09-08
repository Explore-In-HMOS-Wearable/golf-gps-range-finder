import { GolfClub } from '../model/GolfClub';
import { ClubDetail } from '../model/ClubDetail';

@ObservedV2
export class ClubDetailViewModel {
  @Trace public club: ClubDetail = {
    id: 0,
    name: '',
    lat: 0,
    lon: 0,
    distance: 0,
    address: '',
    phone: '',
    holes: 0,
    par: 0,
    rating: 0
  };

  public setClub(club: GolfClub) {
    this.club.id = club.id;
    this.club.name = club.name;
    this.club.lat = club.lat;
    this.club.lon = club.lon;
    this.club.distance = club.distance;
    this.club.address = '123 Golf Street, Example City';
    this.club.phone = '+1 555 123 4567';
    this.club.holes = 18;
    this.club.par = 72;
    this.club.rating = 4.2;
  }
}
