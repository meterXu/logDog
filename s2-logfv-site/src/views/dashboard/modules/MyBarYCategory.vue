<template>
  <div id="container"  class="chart-container">

  </div>
</template>

<script>
import * as echarts from 'echarts/core';
import {
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent
} from 'echarts/components';
import { BarChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  BarChart,
  CanvasRenderer
]);
import {getAction} from "../../../api/manage";
export default {
  name: "MyBarYCategory",
  data(){
    return {
      dataSource:[]
    }
  },
  methods:{
    drawPid() {
      let yAxisData = []
      let seriesData = []
      let getchart = echarts.init(document.getElementById('container'))
      getchart.clear()
      this.dataSource.forEach(function(value){
        yAxisData.unshift(value.device_name)
        seriesData.unshift(value.log_count)
      })
      let options = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
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
            data: ['应用日志数']
        },
        grid: {
            left: '20%',
            right: '6%',
            bottom: '6%'
        },
        xAxis: {
            type: 'value',
            boundaryGap: [0, 0.01]
        },
        yAxis: {
            type: 'category',
            data: yAxisData
        },
        series: [
            {
                name: '应用日志数',
                type: 'bar',
                data: seriesData
            }
        ]
      }
      getchart.setOption(options);//加载图表
    }
  },
  async mounted() {
    let res = await getAction("/logfv/web/queryLogCount")
    if (res.success) {
      this.dataSource = res.value||[]
    }else{
      this.$message.warning(res.msg)
    }
    this.drawPid()
    this.$emit('loaded')
  }
}
</script>

<style scoped>
.chart-container{
  height: 560px;
}
</style>
