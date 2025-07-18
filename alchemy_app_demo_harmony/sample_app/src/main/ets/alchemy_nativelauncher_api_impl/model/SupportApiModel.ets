/*
 * Copyright (c) 2025 Lark Technologies Pte. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

export interface ApiRequestModel {
  apiName: string,
  params: string
}

export const supportApiArray: ApiRequestModel[] = [
  {
    apiName: 'login',
    params: ''
  },
  {
    apiName: 'showToast',
    params: '{"title":"ToastTitle","icon":"","duration":1500,"mask":false}'
  },
  {
    apiName: 'chooseContact',
    params: '{"multi":true,"ignore":true,"maxNum":100,"limitTips":"","externalContact":true,"enableChooseDepartment":true,"choosenIds":[],"chosenIds":[],"disableChosenIds":[],"showRelatedOrganizations":false,"exEmployeeFilterType":""}'
  },
  {
    apiName: 'getDeviceID',
    params: ''
  },
  {
    apiName: 'getNetworkType',
    params: ''
  },
  {
    apiName: 'getSystemInfo',
    params: ''
  },
  {
    apiName: 'share',
    params: '{"url":"https://www.feishu.cn/","content":"","title":"飞书官网","contentType":"url","image":""}'
  },
  {
    apiName: 'enterProfile',
    params: '{"openid":"ou_d0fedf49fa22b9fe2401e45289bcdbff"}'
  },
  {
    apiName: 'getUserInfo',
    params: '{"withCredentials":false}'
  },
  {
    apiName: 'filePicker',
    params: '{"maxNum":0,"isSystem":false,"pickerTitle":"","pickerConfirm":"","supportFileTypes":[]}'
  },
  {
    apiName: 'openDocument',
    params: '{"filePath":"ttfile://temp/1747797201659_最大亮度值兼容适配建议.pdf","fileType":"docx","showMenu":false}'
  },
  {
    apiName: 'chooseImage',
    params: '{"cameraDevice":"back","count":9,"sizeType":[],"sourceType":[],"isSaveToAlbum":"0"}'
  },
  {
    apiName: 'previewImage',
    params: '{"urls":["https://sf3-scmcdn2-cn.feishucdn.com/ee/lark/open/web/static/app-banner.05b68b58.png"],"header":{"testHeader":"1234567890"},"current":"","shouldShowSaveOption":false}'
  },
  {
    apiName: 'shareWebContent',
    params: '{"title":"我是分享标题","url":"https://www.feishu.cn/"}'
  },
  {
    apiName: 'invokeCustomAPI',
    params: '{"name":"testSuccess","args":{"testParam":"aaa"}}'
  },
  {
    apiName: 'invokeCustomAPI',
    params: '{"name":"testFail"}'
  }
]

