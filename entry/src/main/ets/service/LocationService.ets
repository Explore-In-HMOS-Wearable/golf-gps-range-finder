import { geoLocationManager } from '@kit.LocationKit';
import type { BusinessError } from '@kit.BasicServicesKit';

export function getCurrentLocation(): Promise<LocationModel> {
  const request: geoLocationManager.SingleLocationRequest = {
    locatingPriority: geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED,
    locatingTimeoutMs: 10000
  };

  return geoLocationManager.getCurrentLocation(request)
    .then((result: geoLocationManager.Location): LocationModel => {
      return {
        lat: result.latitude,
        lon: result.longitude
      } as LocationModel;
    })
    .catch((error: BusinessError) => {
      throw (error instanceof Error ? error : new Error(JSON.stringify(error)));
    });
}

export function isLocationEnabled(): boolean {
  return geoLocationManager.isLocationEnabled();;
}

export function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const toRad = (value: number) => (value * Math.PI) / 180;
  const R = 6371000;

  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);

  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
      Math.sin(dLon / 2) * Math.sin(dLon / 2);

  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return Math.round(R * c);
}

export interface LocationModel {
  lat: number
  lon: number
}