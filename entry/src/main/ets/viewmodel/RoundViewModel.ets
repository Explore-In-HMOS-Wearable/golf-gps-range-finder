import { GolfHole } from '../model/GolfHole';
import { calculateDistance, getCurrentLocation } from '../service/LocationService';
import { bearingToCompassDirection, calculateBearing } from '../util/GeoUtils';

@ObservedV2
export class RoundViewModel {
  @Trace public currentHole: number = 1;
  @Trace public strokes: number = 0;
  @Trace public totalHoles: number = 18;
  @Trace public tempoActive: boolean = false;
  @Trace public scoreCard: number[] = [];
  @Trace public holes: GolfHole[] = [];

  private userLat: number = 0;
  private userLon: number = 0;

  constructor() {
    this.generateMockHoles();
    this.updateUserLocation();
  }

  public addStroke() {
    this.strokes++;
  }

  public removeStroke() {
    if (this.strokes > 0) {
      this.strokes--;
    }
  }

  public nextHole() {
    this.scoreCard.push(this.strokes);
    this.currentHole++;
    this.strokes = 0;
    this.updateUserLocation();
  }

  public toggleTempo() {
    this.tempoActive = !this.tempoActive;
  }

  public isFinished(): boolean {
    return this.currentHole > this.totalHoles;
  }

  public totalStrokes(): number {
    return this.scoreCard.reduce((sum, s) => sum + s, 0) + this.strokes;
  }

  public get currentHoleDirection(): string {
    const hole = this.currentHoleData;
    if (!hole) {
      return 'Unknown';
    }

    const bearing = calculateBearing(this.userLat, this.userLon, hole.lat, hole.lon);
    return bearingToCompassDirection(bearing);
  }

  private generateMockHoles() {
    const baseLat = 41.0960;
    const baseLon = 29.0223;

    for (let i = 1; i <= this.totalHoles; i++) {
      this.holes.push({
        number: i,
        lat: baseLat + Math.random() * 0.001,
        lon: baseLon + Math.random() * 0.001,
        par: 4,
        avgStroke: Math.floor(Math.random() * 4) + 3
      });
    }
  }

  public setStroke(value: number) {
    this.strokes = value;
  }

  async updateUserLocation(): Promise<void> {
    try {
      const location = await getCurrentLocation();
      this.userLat = location.lat;
      this.userLon = location.lon;
    } catch (_) {
      this.userLat = 41.0;
      this.userLon = 29.0;
    }
  }

  public get currentHoleBearing(): number {
    const hole = this.currentHoleData;
    if (!hole) {
      return 0;
    }
    return calculateBearing(this.userLat, this.userLon, hole.lat, hole.lon);
  }

  public get currentHoleData(): GolfHole | undefined {
    return this.holes.find(h => h.number === this.currentHole);
  }

  public get currentHoleDistance(): number {
    const hole = this.currentHoleData;
    if (!hole) {
      return 0;
    }
    return Math.floor(
      calculateDistance(this.userLat, this.userLon, hole.lat, hole.lon)
    );
  }

  public get currentHolePar(): number {
    return this.currentHoleData?.par || 0;
  }

  public get currentHoleAverageStroke(): number {
    return this.currentHoleData?.avgStroke || 0;
  }
}
