/**
 * 轻量级键值持久化，与 Android 端 PrefUtils 行为一致
 * 使用 @ohos.data.preferences 实现
 */
import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
import { PrefKeys } from './PrefKeys';

const PREF_NAME = 'disable_battery_optimization_prefs';

let cachedPreferences: dataPreferences.Preferences | null = null;

/**
 * 初始化并缓存 Preferences 实例，在插件 onAttachedToEngine 时调用
 */
export function initPreferences(context: common.Context): Promise<void> {
  return dataPreferences.getPreferences(context, PREF_NAME)
    .then((prefs: dataPreferences.Preferences) => {
      cachedPreferences = prefs;
    })
    .catch(() => {
      cachedPreferences = null;
    });
}

function getPrefs(): dataPreferences.Preferences | null {
  return cachedPreferences;
}

/**
 * 保存到 Preferences
 */
export function saveToPrefs(key: string, value: boolean | number | string): void {
  const prefs = getPrefs();
  if (!prefs) return;
  try {
    prefs.putSync(key, value);
    prefs.flush();
  } catch (e) {
    // ignore
  }
}

/**
 * 从 Preferences 读取，不存在则返回 defaultValue
 */
export function getFromPrefs(key: string, defaultValue: boolean | number | string): boolean | number | string {
  const prefs = getPrefs();
  if (!prefs) return defaultValue;
  try {
    const val = prefs.getSync(key, defaultValue);
    return val as boolean | number | string;
  } catch (e) {
    return defaultValue;
  }
}

/**
 * 是否包含指定 key
 */
export function hasKey(key: string): boolean {
  const prefs = getPrefs();
  if (!prefs) return false;
  try {
    return prefs.hasSync(key);
  } catch (e) {
    return false;
  }
}

/**
 * 移除指定 key
 */
export function removeFromPrefs(key: string): void {
  const prefs = getPrefs();
  if (!prefs) return;
  try {
    prefs.deleteSync(key);
    prefs.flush();
  } catch (e) {
    // ignore
  }
}
