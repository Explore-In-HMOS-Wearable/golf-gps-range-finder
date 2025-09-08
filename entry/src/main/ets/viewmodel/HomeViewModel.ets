import { GolfClub } from '../model/GolfClub';
import { calculateDistance, getCurrentLocation } from '../service/LocationService';

@ObservedV2
export class HomeViewModel {
  @Trace public clubs: GolfClub[] = [];
  @Trace public isLoading: boolean = false;

  constructor() {
    this.loadClubsByLocation();
  }

  public async loadClubsByLocation(): Promise<void> {
    this.isLoading = true;
    try {
      const location = await getCurrentLocation();

      setTimeout(() => {
        const mockClubs: GolfClub[] = [{
          id: 1,
          name: 'Paris International GC',
          distance: 0,
          lat: 48.8566,
          lon: 2.3522
        },
          {
            id: 2,
            name: 'London Fairways',
            distance: 0,
            lat: 51.5074,
            lon: -0.1278
          },
          {
            id: 3,
            name: 'Berlin Green Hills',
            distance: 0,
            lat: 52.5200,
            lon: 13.4050
          },
          {
            id: 4,
            name: 'Madrid Royal Club',
            distance: 0,
            lat: 40.4168,
            lon: -3.7038
          },
          {
            id: 5,
            name: 'Rome Eagle Course',
            distance: 0,
            lat: 41.9028,
            lon: 12.4964
          },
          {
            id: 6,
            name: 'Vienna Masters Park',
            distance: 0,
            lat: 48.2082,
            lon: 16.3738
          },
          {
            id: 7,
            name: 'Istanbul Golf Club',
            distance: 0,
            lat: 41.0960,
            lon: 29.0223
          }
        ];

        let clubsWithDistance: GolfClub[] = [];
        for (let i = 0; i < mockClubs.length; i++) {
          let club = mockClubs[i];
          let distance = calculateDistance(location.lat, location.lon, club.lat, club.lon) / 1000;
          clubsWithDistance.push({
            id: club.id,
            name: club.name,
            lat: club.lat,
            lon: club.lon,
            distance: distance
          });
        }

        clubsWithDistance.sort((a, b) => a.distance - b.distance);
        this.clubs = clubsWithDistance;
        this.isLoading = false;
      }, 1000);
    } catch (error) {
      this.loadMockData();
    }
  }

  public loadMockData(): void {
    this.isLoading = true;
    setTimeout(() => {
      this.clubs = [
        {
          id: 1,
          name: 'Paris International GC',
          distance: 0,
          lat: 48.8566,
          lon: 2.3522
        },
        {
          id: 2,
          name: 'London Fairways',
          distance: 0,
          lat: 51.5074,
          lon: -0.1278
        },
        {
          id: 3,
          name: 'Berlin Green Hills',
          distance: 0,
          lat: 52.5200,
          lon: 13.4050
        },
        {
          id: 4,
          name: 'Madrid Royal Club',
          distance: 0,
          lat: 40.4168,
          lon: -3.7038
        },
        {
          id: 5,
          name: 'Rome Eagle Course',
          distance: 0,
          lat: 41.9028,
          lon: 12.4964
        },
        {
          id: 6,
          name: 'Vienna Masters Park',
          distance: 0,
          lat: 48.2082,
          lon: 16.3738
        },
        {
          id: 7,
          name: 'Istanbul Golf Club',
          distance: 0,
          lat: 41.0960,
          lon: 29.0223
        }
      ];
      this.isLoading = false;
    }, 1500);
  }
}
