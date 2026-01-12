export function asString(res: Resource): string {
  if (typeof res === 'string') {
    return res;
  }
  if (res && typeof res === 'object' && typeof res.toString === 'function') {
    return res.toString();
  }
  return `${res}`;
}
