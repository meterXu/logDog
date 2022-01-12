<template>
  <a-card :bordered="false">
    <div class="logfv-date-pie">
      <a-row style="width: 1100px;">
       <a-col class="logType-legend" v-for="item in webLogTypeConfigs" :key="item.logType" :span="2">
         <span class="logType-color" :style="{'background': item.displayColor}"></span>
         <span class="logType-title">{{item.logTypeName}}</span>
       </a-col>
        <a-col class="logType-legend" :span="2">
          <span class="logType-color" :style="{'background': '#ddd'}"></span>
          <span class="logType-title">无数据</span>
        </a-col>
      </a-row>
      <ConfigProvider :locale="locale">
        <Calendar @panelChange="onPanelChange" @select="onSelect" style="height: 100%" v-model="date" :mode="mode">
          <div slot="dateCellRender" slot-scope="value" class="events">
            <Pie :date="value" :datas="datas" @click="showSysRanking"/>
          </div>
          <div slot="monthCellRender" slot-scope="value" class="events">
            <Treemap :date="value" :datas="datas" />
          </div>
        </Calendar>
      </ConfigProvider>
    </div>
  </a-card>
</template>

<script>
import Pie from '../../components/Pie'
import {ConfigProvider, Calendar} from 'ant-design-vue'
import zh_CN from 'ant-design-vue/lib/locale-provider/zh_CN'
import Treemap from "../../components/Treemap";
import moment from 'moment'
import {webLogTypeConfigs} from '../../mixins/logtypes'
import {getAction} from "../../api/manage";
export default {
  name: 'CalendarView',
  props: {
    msg: String
  },
  data() {
    return {
      locale: zh_CN,
      date:null,
      datas:null,
      yearValue:null,
      mode:'month',
      webLogTypeConfigs:webLogTypeConfigs,
      url:{
        getCountByGroupByLogType:"/logfv/web/getCountByGroupByLogType"
      }
    }
  },
  components: {Treemap, ConfigProvider, Calendar, Pie},
  methods: {
    async onPanelChange(date,mode) {
      let year = date.get('year')
      let month = date.get('month')+1
      this.mode = mode
      switch (mode){
        case "month":{
          let res = await getAction(this.url.getCountByGroupByLogType,{
            year:year,
            month:month
          })
          this.datas = res.value
        }break;
        case "year":{
          if(this.yearValue!==year){
            let res = await getAction(this.url.getCountByGroupByLogType,{
              year:year,
              month:""
            })
            this.datas = res.value
            this.yearValue = year
          }

        }break;
      }
    },
    onSelect(date){
      switch (this.mode){
        case 'year':{
          this.mode='month'
          this.onPanelChange(date,this.mode)
          this.yearValue = null
        }break;
        case 'month':{
        }break;
      }
    },
    showSysRanking(date,dayData){
      this.$router.push({
        name: `logfvSite_calendar_sysRanking`,
        params:{
          date:date,
          dayData:dayData
        }
      })
    }
  },
   created() {
     this.date = moment()
     this.onPanelChange(this.date,"month")
  }
}
</script>


<style scoped>
.logType-legend{
  display: flex;
  align-items: center;
}
.logType-color{
  width: 12px;
  height: 12px;
  display: inline-block;
  border-radius: 6px;
}
.logType-title{
  display: inline-block;
  margin-left: 8px;
}
</style>

<style lang="less">
.logfv-date-pie{
  .ant-fullcalendar-content .events {
    height: 100%;
  }
  .ant-fullcalendar-fullscreen .ant-fullcalendar-month, .ant-fullcalendar-fullscreen .ant-fullcalendar-date {
    height: 120px;
  }
  .ant-fullcalendar-fullscreen .ant-fullcalendar-content{
    overflow: unset;
  }
}

</style>
