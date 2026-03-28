/*
 * Copyright (C) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import bundleManager from '@ohos.bundle.bundleManager';
import { promptAction } from '@kit.ArkUI';
import { PrefKeys } from './PrefKeys';
import * as PrefUtils from './PrefUtils';
import { autoStartupManager } from '@kit.AbilityKit';

const CHANNEL_NAME = 'in.jvapps.disable_battery_optimization';

// 系统设置应用
const SETTINGS_BUNDLE = 'com.huawei.hmos.settings';
const SETTINGS_ABILITY = 'com.huawei.hmos.settings.MainAbility';


interface GeneratedTypeLiteralInterface {
  index: number;
}


export default class DisableBatteryOptimizationPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private appContext: common.Context | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return 'DisableBatteryOptimizationPlugin';
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.appContext = binding.getApplicationContext() as common.Context;
    PrefUtils.initPreferences(this.appContext);
    this.channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    this.channel.setMethodCallHandler(this);
  }

  onDetachedFromEngine(_binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }
    this.channel = null;
    this.appContext = null;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    switch (call.method) {
      // 弹出引导用户开启「自启动」的对话框，并跳转到系统自启动设置。
      case 'showEnableAutoStart':
        // this.handleShowEnableAutoStart(call, result);
        // this.openAppSettings("application_info_entry", result);
        break;
      // 弹出引导用户关闭「厂商省电/耗电管理」的对话框，并跳转到对应设置。
      case 'showDisableManBatteryOptimization':
        // this.handleShowDisableManBatteryOptimization(call, result);
        // this.openSettings("battery", result);
        break;
      // 请求系统忽略电池优化（跳转电池/应用信息设置页）。
      case 'showDisableBatteryOptimization':
        // this.handleShowDisableBatteryOptimization(result);
        break;
      // 一次性引导：自启动 → 厂商省电 → 系统忽略电池优化。
      case 'disableAllOptimizations':
        // this.handleDisableAllOptimizations(call, result);
        break;
      // 查询是否已开启自启动。
      case 'isAutoStartEnabled':
        result.success(this.isAutoStartEnabled());
        break;
      // 查询应用是否已加入系统「忽略电池优化」白名单。
      case 'isBatteryOptimizationDisabled':
        // result.success(this.isBatteryOptimizationDisabled());
        break;
      // 查询用户是否已关闭厂商省电/耗电管理限制。
      case 'isManBatteryOptimizationDisabled':
        // result.success(this.getManBatteryOptimization());
        break;
      // 查询自启动、厂商省电、系统电池优化是否均已处理。
      case 'isAllOptimizationsDisabled':
        result.success(
          this.getManAutoStart() &&
          this.isBatteryOptimizationDisabled() &&
          this.getManBatteryOptimization()
        );
        break;
      default:
        result.notImplemented();
    }
  }

  private handleShowEnableAutoStart(call: MethodCall, result: MethodResult): void {
    try {
      const args = call.args as Array<string>;
      if (args != null && args.length >= 2) {
        const autoStartTitle = String(args[0]);
        const autoStartMessage = String(args[1]);
        console.info(`snake autoStartTitle: ${autoStartTitle}`);
        console.info(`snake autoStartMessage: ${autoStartMessage}`);
        this.showAutoStartEnabler(autoStartTitle, autoStartMessage, () => {
          this.setManAutoStart(true);
        }, () => {
          this.setManAutoStart(false);
        });
        result.success(true);
      } else {
        result.success(false);
      }
    } catch (e) {
      result.success(false);
    }
  }

  private handleShowDisableManBatteryOptimization(call: MethodCall, result: MethodResult): void {
    try {
      const args = call.args as Array<string>;
      if (args != null && args.length >= 2) {
        const manBatteryTitle = String(args[0]);
        const manBatteryMessage = String(args[1]);
        this.showManBatteryOptimizationDisabler(manBatteryTitle, manBatteryMessage, false);
        result.success(true);
      } else {
        result.success(false);
      }
    } catch (e) {
      result.success(false);
    }
  }

  private handleShowDisableBatteryOptimization(result: MethodResult): void {
    try {
      this.showIgnoreBatteryPermissions();
      result.success(true);
    } catch (e) {
      result.success(false);
    }
  }

  private handleDisableAllOptimizations(call: MethodCall, result: MethodResult): void {
    try {
      const args = call.args as Array<string>;
      if (args != null && args.length >= 4) {
        const autoStartTitle = String(args[0]);
        const autoStartMessage = String(args[1]);
        const manBatteryTitle = String(args[2]);
        const manBatteryMessage = String(args[3]);
        this.handleIgnoreAllBatteryPermission(
          autoStartTitle,
          autoStartMessage,
          manBatteryTitle,
          manBatteryMessage
        );
        result.success(true);
      } else {
        result.success(false);
      }
    } catch (e) {
      result.success(false);
    }
  }

  /**
   * 弹框样式与 Android BatteryOptimizationUtil.showBatteryOptimizationDialog 一致：
   * 标题（空时使用默认）、正文、负按钮 Cancel、正按钮 Ok；点击 Ok 执行 onPositive，点击 Cancel 执行 onNegative。
   */
  private showBatteryOptimizationDialog(
    title: string,
    message: string,
    onPositive: () => void,
    onNegative: () => void
  ): void {
    const dialogTitle = (title != null && title.length > 0)
      ? title
      : '您的设备具有额外的电池优化设置';
    const dialogMessage = (message != null && message.length > 0)
      ? message
      : '请开启相关设置以保证应用正常运行。';
    promptAction.showDialog({
      title: dialogTitle,
      message: dialogMessage,
      buttons: [
        { text: 'Cancel', color: '#999999' },
        { text: 'Ok', color: '#007DFF' }
      ]
    }).then((data: GeneratedTypeLiteralInterface) => {
      if (data.index === 1) {
        onPositive();
      } else {
        onNegative();
      }
    }).catch(() => {
      onNegative();
    });
  }

  /** 弹出引导对话框，用户点击 Ok 后跳转应用信息 */
  private showAutoStartEnabler(
    title: string,
    message: string,
    positiveCallback: () => void,
    negativeCallback: () => void
  ): void {
    const self = this;
    this.showBatteryOptimizationDialog(
      title,
      message,
      () => {
        positiveCallback();
        self.openAppInfoOrBatterySettings();
      },
      negativeCallback
    );
  }

  /** 先弹出，点击 Ok 后跳转电池 */
  private showManBatteryOptimizationDisabler(
    title: string,
    message: string,
    thenShowNativeBattery: boolean
  ): void {
    const self = this;
    this.showBatteryOptimizationDialog(
      title,
      message,
      () => {
        self.setManBatteryOptimization(true);
        if (thenShowNativeBattery) {
          self.showIgnoreBatteryPermissions();
        } else {
          self.openBatterySettings();
        }
      },
      () => {
        if (thenShowNativeBattery) {
          self.showIgnoreBatteryPermissions();
        } else {
          self.openBatterySettings();
        }
      }
    );
  }

  /** 打开系统“忽略电池优化”或应用详情/电池设置页 */
  private showIgnoreBatteryPermissions(): void {
    if (!this.isBatteryOptimizationDisabled()) {
      this.openBatterySettings();
    }
  }

  /** 一次性引导：自启动 → 厂商省电 → 系统电池优化 */
  private handleIgnoreAllBatteryPermission(
    autoStartTitle: string,
    autoStartMessage: string,
    manBatteryTitle: string,
    manBatteryMessage: string
  ): void {
    const isManBatteryDisabled = this.getManBatteryOptimization();
    if (!this.getManAutoStart()) {
      this.showAutoStartEnabler(autoStartTitle, autoStartMessage, () => {
        this.setManAutoStart(true);
        if (!isManBatteryDisabled) {
          this.showManBatteryOptimizationDisabler(manBatteryTitle, manBatteryMessage, true);
        } else {
          this.showIgnoreBatteryPermissions();
        }
      }, () => {
        if (!isManBatteryDisabled) {
          this.showManBatteryOptimizationDisabler(manBatteryTitle, manBatteryMessage, true);
        } else {
          this.showIgnoreBatteryPermissions();
        }
      });
    } else {
      if (!isManBatteryDisabled) {
        this.showManBatteryOptimizationDisabler(manBatteryTitle, manBatteryMessage, true);
      } else {
        this.showIgnoreBatteryPermissions();
      }
    }
  }

  private setManBatteryOptimization(val: boolean): void {
    PrefUtils.saveToPrefs(PrefKeys.IS_MAN_BATTERY_OPTIMIZATION_ACCEPTED, val);
  }

  private getManBatteryOptimization(): boolean {
    if (PrefUtils.hasKey(PrefKeys.IS_MAN_BATTERY_OPTIMIZATION_ACCEPTED)) {
      return PrefUtils.getFromPrefs(PrefKeys.IS_MAN_BATTERY_OPTIMIZATION_ACCEPTED, false) as boolean;
    }
    PrefUtils.saveToPrefs(PrefKeys.IS_MAN_BATTERY_OPTIMIZATION_ACCEPTED, true);
    return true;
  }

  private setManAutoStart(val: boolean): void {
    PrefUtils.saveToPrefs(PrefKeys.IS_MAN_AUTO_START_ACCEPTED, val);
  }

  // 获取当前应用的开机自启动状态,从API version 21开始支持
  private isAutoStartEnabled(): boolean {
    try {
      autoStartupManager.getAutoStartupStatusForSelf().then((isAutoStartup: boolean) => {
        console.info(`getAutoStartupStatusForSelf success, isAutoStartup: ${JSON.stringify(isAutoStartup)}.`);
        return isAutoStartup;
      }).catch((err: BusinessError) => {
        console.error(`getAutoStartupStatusForSelf failed, err code: ${err.code}, err msg: ${err.message}.`);
        return false;
      });
    } catch (err) {
      let code = (err as BusinessError).code;
      let msg = (err as BusinessError).message;
      console.error(`getAutoStartupStatusForSelf failed, err code: ${code}, err msg: ${msg}.`);
      return false;
    }
    return false;
  }


  private getManAutoStart(): boolean {
    if (PrefUtils.hasKey(PrefKeys.IS_MAN_AUTO_START_ACCEPTED)) {
      return PrefUtils.getFromPrefs(PrefKeys.IS_MAN_AUTO_START_ACCEPTED, false) as boolean;
    }
    PrefUtils.saveToPrefs(PrefKeys.IS_MAN_AUTO_START_ACCEPTED, true);
    return true;
  }

  /** 鸿蒙无“忽略电池优化”接口，视为已禁用优化 */
  private isBatteryOptimizationDisabled(): boolean {
    return true;
  }

  private openBatterySettings(): void {

    let want: Want = {
      bundleName: SETTINGS_BUNDLE,
      abilityName: SETTINGS_ABILITY,
      uri: 'battery',
    }
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(want).then(() => {
      console.info('Start settings ability successfully.');
    }).catch((err: BusinessError) => {
      console.info(`Failed to startAbility. Code: ${err.code}, message: ${err.message}`);
    });
  }

  private openAppInfoOrBatterySettings(): void {
    let bundleName = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT).name;
    let wantInfo: Want = {
      bundleName: SETTINGS_BUNDLE,
      abilityName: SETTINGS_ABILITY,
      uri: 'application_info_entry',
      parameters: {
        pushParams: bundleName
      }
    };
    let context = getContext(this) as common.UIAbilityContext;
    context.startAbility(wantInfo).then(() => {
      console.info('Start settings ability successfully.');
    }).catch((err: BusinessError) => {
      console.error(`Failed to startAbility. Code: ${err.code}, message: ${err.message}`);
    });
  }

  // 1. 跳转到系统电池管理页
  jumpToBatterySettings(): void {
    this.startSettingsAbility('battery');
  }

  // 2. 跳转到应用详情页（不含耗电信息）
  jumpToAppDetails(): void {
    let bundleName = bundleManager.getBundleInfoForSelfSync(
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION
    ).name;

    this.startSettingsAbility('application_info_entry', bundleName);
  }

  // 通用跳转方法
  private startSettingsAbility(uri: string, pushParams?: string): void {
    let context = getContext(this) as common.UIAbilityContext;

    let want: Want = {
      bundleName: SETTINGS_BUNDLE,
      abilityName: SETTINGS_ABILITY,
      uri: uri,
      parameters: {
        pushParams: pushParams || context.abilityInfo.bundleName
      }
    };

    context.startAbility(want)
      .then(() => console.info(`Start ${uri} successfully`))
      .catch((err: BusinessError) => {
        console.error(`Failed to start ${uri}. Code: ${err.code}, message: ${err.message}`);
      });
  }
}
