<template>
  <div id="logTooltip" class="logTooltip" :style="{left:`${x}px`,top:`${y}px`}" v-if="showing&&hoveredLog">
    日志ID: {{hoveredLog.id}}
    <br />
    时间: {{time}}
    <br />
    日志类型:
    <span :style="{color:hoveredLog.logType.displayColor}">{{hoveredLog.logType.logTypeName}}</span>
  </div>
</template>

<script>
import moment from 'moment'
export default {
  name: "LogTooltip",
  props:['x','y','color','hoveredLog', 'showing'],
  computed:{
    time(){
      return moment(this.hoveredLog.time).format("HH:mm:ss.SSS")
    }
  }
}
</script>

<style scoped>
.logTooltip{
  position: absolute;
  box-shadow: 0 2px 8px rgb(0 0 0 / 15%);
  background-color: white;
  border-radius: 5px;
  padding: 0px 10px;
  line-height: 25px;
  z-index: 999
}
</style>
