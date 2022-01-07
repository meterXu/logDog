<template>
<div id="chart" class="chart-container">

</div>
</template>

<script>
import * as echarts from 'echarts/core';
import {
  TitleComponent,
  ToolboxComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent
} from 'echarts/components';
import { LineChart } from 'echarts/charts';
import { UniversalTransition } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';
import {webLogTypeConfigs} from '../../../mixins/logtypes'
import {getAction} from "../../../api/manage";
echarts.use([
  TitleComponent,
  ToolboxComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  LineChart,
  CanvasRenderer,
  UniversalTransition
]);
export default {
  name: "MyAreaStackGradient",
  data(){
    return {
      dataSource:[]
    }
  },
  methods:{
    drawPid() {
      let that = this
      let getchart = echarts.init(document.getElementById('chart'))
      getchart.clear()
      let optionsColor = [];
      let legendData = [];
      let series = [];
      let seriesGroup = [];
      let xAxisData = [];
      let seriesDatas = [];
      seriesGroup = this.getSevenDaysDate(this.arrayGroupBy("date"))
      seriesDatas = this.arrayGroupBy("logType")
      if(seriesGroup.length===1){
        seriesGroup.splice(0,0,[{
          count: 0,
          date:'--------',
          logType: 'info'
        }])
        seriesDatas.forEach(s=>{
          s.splice(0,0,{
            count: 0,
            date:'--------',
            logType: 'info'
          })
        })
      }
      seriesGroup.forEach(function(value){
        xAxisData.push(`${value[0].date.substr(4,2)}月${value[0].date.substr(6,2)}日`)
      })
      webLogTypeConfigs.forEach(function(type){
        let seriesData = []
        optionsColor.push(type.displayColor)
        legendData.push(type.logTypeName)
        seriesGroup.forEach(da=>{
          let v = 0
          seriesDatas.forEach(sds=>{
            let ss =sds.find(c=>c.logType===type.logType&& c.date ===da[0].date )
            if(ss){
              v = ss.count
            }
          })
          seriesData.push(v)
        })
        series.push({
            name: type.logTypeName,
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
              width: 0
            },
            showSymbol: false,
            areaStyle: {
              opacity: 0.8,
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                offset: 0,
                color: type.gradualColor
              }, {
                offset: 1,
                color: type.displayColor
              }])
            },
            emphasis: {
              focus: 'series'
            },
            data: seriesData
        })
      })
      let options={
        color: optionsColor,
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            label: {
              backgroundColor: '#6a7985'
            }
          },
          formatter: function (params) {
            let relVal = params[0].name;
            for (let i = 0, l = params.length; i < l; i++) {
              relVal += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + params[i].value + '条'
            }
            return relVal;
          }
        },
        legend: {
          data: legendData
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [
          {
            type: 'category',
            boundaryGap: false,
            data: xAxisData
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series:series
      }

      getchart.setOption(options);//加载图表
    },
    // 分组函数
    groupBy(f) {
      let groups = {};
      this.dataSource.forEach(function (o) {
          var group = JSON.stringify(f(o));
          groups[group] = groups[group] || [];
          groups[group].push(o);
      });
      return Object.keys(groups).map(function (group) {
          return groups[group];
      });
    },
    arrayGroupBy (type){
      let sorted = this.groupBy(function (item) {
          return [item[type]];
      });
      return sorted;
    },
    changes() {
      console.log("changes");
    },
    getSevenDaysDate(array) {
      let arr = []
      for (let i = array.length-1; i >= (array.length-7); i--) {
        if(array[i]!=null&&array[i]!=undefined) {
          arr.push(array[i])
        }
      }
      return arr.reverse()
    }
  },
  async mounted() {
    await getAction("/logfv/web/queryLogType").then((res) => {
     if (res.success) {
       this.dataSource = res.value.pageData
     }else{
       this.$message.warning(res.msg)
     }
    })
    this.drawPid()
    this.$emit('loaded')
  }
}
</script>

<style scoped>
.chart-container{
  width: 98%;
  height: 560px;
}
</style>
