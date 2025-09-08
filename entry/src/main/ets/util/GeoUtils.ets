export function calculateBearing(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const toRadians = (deg: number) => deg * (Math.PI / 180);
  const toDegrees = (rad: number) => rad * (180 / Math.PI);

  const φ1 = toRadians(lat1);
  const φ2 = toRadians(lat2);
  const Δλ = toRadians(lon2 - lon1);

  const y = Math.sin(Δλ) * Math.cos(φ2);
  const x = Math.cos(φ1) * Math.sin(φ2) - Math.sin(φ1) * Math.cos(φ2) * Math.cos(Δλ);
  const θ = Math.atan2(y, x);
  let bearing = (toDegrees(θ) + 360) % 360;

  return bearing;
}

export function bearingToCompassDirection(bearing: number): string {
  const directions = [
    'N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW', 'N'
  ];
  const index = Math.round(bearing / 45);
  return directions[index];
}
