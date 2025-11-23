export function calculateBearing(
  latitude1: number,
  longitude1: number,
  latitude2: number,
  longitude2: number
): number {
  const toRadians = (degrees: number) => degrees * (Math.PI / 180);
  const toDegrees = (radians: number) => radians * (180 / Math.PI);

  const lat1Rad = toRadians(latitude1);
  const lat2Rad = toRadians(latitude2);
  const deltaLonRad = toRadians(longitude2 - longitude1);

  const y = Math.sin(deltaLonRad) * Math.cos(lat2Rad);
  const x =
    Math.cos(lat1Rad) * Math.sin(lat2Rad) -
      Math.sin(lat1Rad) * Math.cos(lat2Rad) * Math.cos(deltaLonRad);
  const angle = Math.atan2(y, x);

  return (toDegrees(angle) + 360) % 360;
}

export function bearingToCompassDirection(bearing: number): string {
  const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW', 'N'];
  const index = Math.round(bearing / 45);
  return directions[index];
}
