import { getSwiper, getDailyRecommend } from '../apis';
import { DailyRecommendType } from '../models/Index';

@Component
export default struct Recommend {
  @Builder
  searchBuilder() {
    Row() {
      Row({ space: 8 }) {
        Image($r('app.media.ic_search'))
          .width(20)
          .fillColor('#a8a8a8')

        TextInput({ placeholder: '搜索歌曲、歌手、专辑' })
          .padding({ left: 4 })
          .placeholderColor('#888888')
          .backgroundColor(Color.Transparent)
          .fontSize(15)
          .layoutWeight(1)

        Image($r('app.media.ic_code'))
          .width(22)
          .fillColor('#a8a8a8')
      }
      .width('100%')
      .height(40)
      .backgroundColor('#2a2a2a')
      .borderRadius(25)
      .padding({ left: 12, right: 12 })
      .shadow({ radius: 4, color: '#00000030' })
    }
    .width('100%')
    .padding({ top: 16, bottom: 12, left: 12, right: 12 })
  }

  @State swiperList: string[] = [];
  @State dailyRecommend: DailyRecommendType[] = [];

  async aboutToAppear() {
    this.swiperList = await getSwiper() as string[];
    this.dailyRecommend = await getDailyRecommend() as DailyRecommendType[];
  }

  @Builder
  swiperBuilder() {
    Swiper() {
      ForEach(this.swiperList, (item: string) => {
        Image(item)
          .width('100%')
          .aspectRatio(720 / 330)
          .borderRadius(12)
          .shadow({ radius: 8, color: '#00000050' })
      })
    }
    .padding({ left: 12, right: 12, bottom: 8 })
    .width('100%')
    .autoPlay(true)
    .indicatorStyle({
      size: 6,
      color: '#555555',
      selectedColor: '#ffffff'
    })
  }

  // 美化版每日推荐
  @Builder
  dailyBuilder() {
    Column() {
      // 标题栏
      Row() {
        Text('每日推荐')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)

        Text('For You')
          .fontSize(13)
          .fontColor('#ff4d4d')
          .margin({ left: 8 })
          .opacity(0.9)
      }
      .width('100%')
      .padding({ left: 16, top: 12, bottom: 12 })

      // 推荐列表
      ForEach(this.dailyRecommend, (item: DailyRecommendType) => {
        Row({ space: 12 }) {
          // 封面图
          Image(item.img)
            .width(55)
            .height(55)
            .borderRadius(8)
            .shadow({ radius: 4, color: '#00000040' })

          // 文字区域
          Column({ space: 4 }) {
            Text(item.title)
              .fontSize(16)
              .fontColor(Color.White)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(item.type)
              .fontSize(12)
              .fontColor('#999999')
              .maxLines(1)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor('#242424')
        .borderRadius(12)
        .margin({ left: 12, right: 12, bottom: 6 })
        .shadow({ radius: 3, color: '#00000020' })
      })
    }
    .width('100%')
  }

  build() {
    Scroll() {
      Column() {
        this.searchBuilder()
        this.swiperBuilder()
        this.dailyBuilder()
      }
      .constraintSize({ minHeight: '100%' })
    }
    .backgroundColor('#1a1a1a')
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }
}