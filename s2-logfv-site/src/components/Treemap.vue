<template>
  <div v-show="chartData.init" ref="treemap" class="treemap"></div>
</template>

<script>
import * as echarts from 'echarts/core';
import { TreemapChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';
import {webLogTypeConfigs, getNoValue, getNoValueColor, getNoValueTooltip} from "../mixins/logtypes";
echarts.use([TreemapChart, CanvasRenderer]);

export default {
  name: "Treemap",
  props:["date","datas"],
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
        init:false,
      },
      noValue:99.99
    }
  },
  watch:{
    datas:{
      handler(){
        this.chartData.init = false
        this.setChartData()
        if(this.chartData.init){
          this.$nextTick(()=>{
            this.initTreeMap()
          })
        }
      },
      immediate:true
    }
  },
  methods:{
    setChartData(){
      let year = this.date.get('year')
      let month = this.date.get('month')+1
      if(this.datas&&typeof(this.datas)==='object'){
        let keys= Object.keys(this.chartData)
        this.datas.forEach(c=>{
          if(c.record_year===year&&c.record_month===month){
            this.chartData.init = true
            if(keys.find(d=>d===c.log_type)){
              this.chartData[c.log_type] = c.num
            }else{
              this.chartData['other'] += c.num
            }
          }
        })
      }
    },
    initTreeMap(){
      let that=this
      let treeMapData = webLogTypeConfigs.map((c,index)=>{
        let value = this.chartData[Object.keys(this.chartData)[index]]
        return {
          name: c.logTypeName,
          value: getNoValue(value,this.noValue),
          itemStyle :{color:getNoValueColor(value,c.displayColor)}
        }
      })
      let chartDom = this.$refs.treemap
      let myChart = echarts.init(chartDom);
      let option = {
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            return params.marker + params.name + '<div style="text-align: right">'+getNoValueTooltip(params.value,that.noValue)+'条</div>'
          }
        },
        series: [
          {
            type: 'treemap',
            breadcrumb: {
              show: false
            },
            data: treeMapData
          }
        ]
      };
      option && myChart.setOption(option);
    }
  },
}
</script>

<style scoped>
.treemap {
  width: 100%;
  height: 100%;
}
</style>
