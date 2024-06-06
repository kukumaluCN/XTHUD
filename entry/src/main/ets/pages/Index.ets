
import { XTHUDManager } from '@jxt/xt_hud'
import {
  XTHUDToastOptions,
  XTHUDLoadingOptions,
  XTHUDProgressOptions,
  XTHUDToast,
  XTHUDLoading,
  XTHUDProgress
} from '@jxt/xt_hud'

@Entry
@Component
struct XTDemo {
  private scroller: Scroller = new Scroller()
  private progress: number = 0
  private interval: number | null = null

  build() {
    Scroll(this.scroller) {
      Column({ space: 2 }) {
        // toast组件挂载，可以不做任何配置
        XTHUDToast()
        XTHUDToast({
          globalOptions: (options: XTHUDToastOptions) => {
            options.isQueueMode = false
            options.hidingDelay = 1000
            options.isModal = false
            options.alignment = DialogAlignment.Center
          }
        })

        // XTHUDLoading()
        XTHUDLoading({
          globalOptions: (options: XTHUDLoadingOptions) => {
            // options.iconSize = {width: 100, height: 100}
            options.maskColor = '#33000000'
          }
        })

        // XTHUDProgress()
        XTHUDProgress({
          globalOptions: (options: XTHUDProgressOptions) => {
            // options.iconSize = {width: 100, height: 100}
            // options.fontSize = 25
            // options.progressFontSize = 20
            options.strokeWidth = 6
          }
        })


        Button('show toast')
          .onClick(() => {
            XTHUDManager.showToast('toast', {
              completionCallback: () => {
                console.log('正常结束')
              },
              cancelCallback: () => {
                console.log('提前结束')
              }
            })
            setTimeout(() => {
              XTHUDManager.hideToast()
            }, 3000)
          })


        Button('show toast with callback')
          .onClick(() => {
            XTHUDManager.showToast('新的文本新的文本新的文本新的文本新的文本新的文本新的文本新的文本', {
              backgroundColor: '#CC0000FF',
              borderRadius: 5,
              cancelCallback: () => {
                console.log('cancel1')
              },
              completionCallback: () => {
                console.log('complete1')
                XTHUDManager.showInfo('info', {
                  cancelCallback: () => {
                    console.log('cancel2')
                  },
                  completionCallback: () => {
                    console.log('complete2')
                  }
                })
              }
            })
          })
        Button('toasts conflict overwritten')
          .onClick(() => {
            XTHUDManager.showInfo('info1')
            XTHUDManager.showError('info2')
            XTHUDManager.showSuccess('info3')
            setTimeout(() => {
              XTHUDManager.hideAllToast()
            }, 1000)
          })
        Button('toast queue with multi-style')
          .onClick(() => {
            XTHUDManager.showInfo('信息弹窗info', {
              isQueueMode: true,
              fontSize: 22,
              textColor: Color.Yellow,
              hidingDelay: 1000,
              completionCallback: () => {
                console.log('信息弹窗info 正常关闭')
              },
              cancelCallback: () => {
                console.log('信息弹窗info 被返回关闭')
              }
            })
            XTHUDManager.showWarning('警告弹窗warning警告弹窗warning', {
              isQueueMode: true,
              tintColor: Color.Orange,
              hidingDelay: 1500,
              backgroundColor: Color.Green,
              completionCallback: () => {
                console.log('警告弹窗warning 正常关闭')
              },
              cancelCallback: () => {
                console.log('警告弹窗warning 被返回关闭')
              }
            })
            XTHUDManager.showSuccess('成功弹窗\nsuccess', {
              isQueueMode: true,
              tintColor: Color.Green,
              textColor: Color.Black,
              hidingDelay: 2000,
              backgroundColor: '#E600FF00',
              borderRadius: 5,
              completionCallback: () => {
                console.log('成功弹窗 正常关闭')
              },
              cancelCallback: () => {
                console.log('成功弹窗 被返回关闭')
              }
            })
            XTHUDManager.showError('错误弹窗 错误弹窗 错误弹窗 错误弹窗', {
              isQueueMode: true,
              tintColor: Color.Red,
              backgroundColor: '#80FF0000',
              iconSize: { width: 150, height: 100 },
              completionCallback: () => {
                console.log('错误弹窗 正常关闭')
              },
              cancelCallback: () => {
                console.log('错误弹窗 被返回关闭')
              }
            })
          })


        Divider()
          .vertical(false)
          .width('100%')
          .color(Color.Black)
          .strokeWidth(0.5)
          .margin(5)


        Button('show harmony style loading')
          .onClick(() => {
            XTHUDManager.showLoading('加载中...')
            setTimeout(() => {
              XTHUDManager.hideLoading()
            }, 3000)
          })
        Button('show ring loading')
          .onClick(() => {
            XTHUDManager.showRingLoading()
            XTHUDManager.showRingLoading('加载中...', {
              strokeWidth: 6,
              completionCallback: () => {
                console.log('Ring loading complete')
              },
              cancelCallback: () => {
                console.log('Ring loading canceled')
              }
            })
            setTimeout(() => {
              XTHUDManager.hideAllLoading()
            }, 3000)
          })
        Button('multi loading conflict flicker')
          .onClick(() => {
            XTHUDManager.showLoading('加载中1...')
            setTimeout(() => {
              XTHUDManager.hideLoading()
              XTHUDManager.showLoading('加载中2...')
              setTimeout(() => {
                XTHUDManager.hideLoading()
              }, 2000)
            }, 1000)
          })
        Button('multi loading smooth')
          .onClick(() => {
            XTHUDManager.showLoading('加载中1...')
            setTimeout(() => {
              XTHUDManager.showLoading('加载中2...')
              setTimeout(() => {
                XTHUDManager.showLoading('加载中3...')
                setTimeout(() => {
                  XTHUDManager.hideAllLoading()
                }, 1000)
              }, 1000)
            }, 1000)
          })
        Button('show loading without text')
          .onClick(() => {
            // XTHUDManager.showLoading('', {
            //   borderRadius: 10,
            //   tintColor: Color.Yellow
            // })
            XTHUDManager.showLoading()
            setTimeout(() => {
              XTHUDManager.hideLoading()
            }, 3000)
          })
        Button('custom loading1')
          .onClick(() => {
            XTHUDManager.showCustomLoading(
              $r("app.media.loading1"),
              '加载中...'
            )
            setTimeout(() => {
              XTHUDManager.hideLoading()
            }, 3000)
          })
        Button('custom loading2')
          .onClick(() => {
            XTHUDManager.showCustomLoading(
              $r('app.media.loading5')
            )
            setTimeout(() => {
              XTHUDManager.hideLoading()
            }, 3000)
          })
        Button('custom loading3 transparent background')
          .onClick(() => {
            XTHUDManager.showCustomLoading(
              $r('app.media.loading5'),
              '',
              {
                backgroundColor: Color.Transparent,
                tintColor: Color.Pink,
                completionCallback: () => {
                  console.log('custom loading3 completed')
                },
                cancelCallback: () => {
                  console.log('custom loading3 cancelled')
                }
              }
            )
            setTimeout(() => {
              XTHUDManager.hideLoading()
            }, 3000)
          })


        Divider()
          .vertical(false)
          .width('100%')
          .color(Color.Black)
          .strokeWidth(0.5)
          .margin(5)


        Button('show progress')
          .onClick(() => {
            this.progress = 0
            this.interval = setInterval(() => {
              this.progress ++
              XTHUDManager.showProgress(this.progress)
              if (this.progress >= 100) {
                clearInterval(this.interval)
                this.interval = null
              }
            }, 100)
          })
        Button('show progress with text')
          .onClick(() => {
            this.progress = 0
            this.interval = setInterval(() => {
              this.progress ++
              XTHUDManager.showProgress(this.progress, '大量资源下载中...', {
                strokeWidth: 8,
                tintColor: Color.Orange,
                completionCallback: () => {
                  console.log('结束', this.progress)
                },
                cancelCallback: () => {
                  console.log('取消一次', this.progress)
                }
              })
              if (this.progress >= 100) {
                clearInterval(this.interval)
                this.interval = null
              }
            }, 200)
          })
        Button('show progress bar')
          .onClick(() => {
            this.progress = 0
            this.interval = setInterval(() => {
              this.progress ++
              XTHUDManager.showBarProgress(this.progress, '大量资源下载中: ', {
                strokeWidth: 8,
                tintColor: Color.Orange
              })
              if (this.progress >= 100) {
                clearInterval(this.interval)
                this.interval = null
              }
            }, 100)
          })
      }
      .width('100%')
    }
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.On)  // 滚动条常驻显示
  }
}