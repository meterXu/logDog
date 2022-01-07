<template>
  <div v-show="init" ref="pie" class="pie" @click="chickHandler"></div>
</template>

<script>
import * as echarts from 'echarts/core';
import {TooltipComponent, LegendComponent} from 'echarts/components';
import {PieChart} from 'echarts/charts';
import {LabelLayout} from 'echarts/features';
import {CanvasRenderer} from 'echarts/renderers';
import {getNoValue, getNoValueColor, getNoValueTooltip, webLogTypeConfigs} from '../mixins/logtypes.js'
echarts.use([
  TooltipComponent,
  LegendComponent,
  PieChart,
  CanvasRenderer,
  LabelLayout
]);

export default {
  name: "Pie",
  props: ["date","datas"],
  data(){
    return {
      chartData:{
        action: null,
        page: null,
        network: null,
        exception: null,
        info: null,
        warn: null,
        debug: null,
        error: null,
        other: null,
      },
      init:false,
      noValue:0.99
    }
  },
  watch:{
    datas:{
     handler(){
       this.init = false
       this.setChartData()
       if(this.init){
         this.$nextTick(()=>{
           this.initPie()
         })
       }
     },
     immediate:true
   }
  },
  methods: {
    setChartData(){
      let year = this.date.get('year')
      let month = this.date.get('month')+1
      let day = this.date.get('D')
      if(this.datas&&typeof(this.datas)==='object'){
        let keys= Object.keys(this.chartData)
        this.datas.forEach(c=>{
          if(c.record_year===year&&c.record_month===month&&c.record_day===day){
            this.init = true
            if(keys.find(d=>d===c.log_type)){
              this.chartData[c.log_type] = c.num
            }else{
              this.chartData['other'] += c.num
            }
          }
        })
      }
    },
    initPie() {
      let that = this
      let chartDom = this.$refs.pie
      let myChart = echarts.init(chartDom);
      let option = {
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            let relVal = params.seriesName;
            relVal += '<br/>' + params.marker + params.name + '<div style="text-align: right">'+getNoValueTooltip(params.value,that.noValue)+'条</div>'
            return relVal;
          }
        },
        legend: false,
        series: [
          {
            name: '被动日志',
            type: 'pie',
            radius: [0, '60%'],
            label: false,
            labelLine: {
              show: false
            },
            data: ['action','page','network','exception'].map((c,index)=>{
              return {
                value: getNoValue(this.chartData[c],this.noValue),
                name: webLogTypeConfigs[index].logTypeName,
                itemStyle :{color:getNoValueColor(this.chartData[c],webLogTypeConfigs[index].displayColor)}
              }
            })
          },
          {
            name: '主动日志',
            type: 'pie',
            radius: ['100%', '80%'],
            labelLine: false,
            data: ['info','warn','debug','error','other'].map((c,index)=>{
              return {
                value: getNoValue(this.chartData[c],this.noValue),
                name: webLogTypeConfigs[index+4].logTypeName,
                itemStyle :{color:getNoValueColor(this.chartData[c],webLogTypeConfigs[index+4].displayColor)}
              }
            })
          }
        ]
      };
      option && myChart.setOption(option);
    },
    chickHandler(){
      this.$emit('click',this.date,this.chartData)
    }
  }
}
</script>

<style scoped>
.pie {
  width: 100%;
  height: 100%;
}
</style>
