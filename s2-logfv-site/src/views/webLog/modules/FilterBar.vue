<template>
  <div class="table-page-search-wrapper">
    <a-form layout="inline" @keyup.enter.native="searchQuery">
      <a-row :gutter="24">
        <a-col :md="6" :sm="8">
          <a-form-item>
            <a-select placeholder="日志类型" mode="multiple" v-model="queryParam.logType">
              <a-icon slot="suffixIcon" type="smile" />
              <a-select-option v-for="item in webLogTypes" :key="item.logType">
                <span :style="{background:item.displayColor}" class="type-icon"></span> {{item.logTypeName}}
              </a-select-option>
            </a-select>
          </a-form-item>
        </a-col>
        <a-col :md="6" :sm="8">
          <a-form-item>
            <a-input placeholder="日志内容" v-model="queryParam.content"></a-input>
          </a-form-item>
        </a-col>
        <a-col :md="6" :sm="6">
          <a-form-item>
            <a-slider range v-model="hours" :min="0" :max="24" />
          </a-form-item>
        </a-col>
        <a-col :md="2" :sm="2">
         <div class="hour-show">
           {{hours[0]+'-'+hours[1]}} 点
         </div>
        </a-col>
        <a-col :md="4" :sm="8">
            <span
                style="float: left;overflow: hidden;"
                class="table-page-search-submitButtons"
            >
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button
                  type="primary"
                  @click="searchReset"
                  icon="reload"
                  style="margin-left: 8px"
              >重置</a-button>
            </span>
        </a-col>
      </a-row>
    </a-form>
  </div>
</template>

<script>
export default {
  name: "FilterBar",
  props:["webLogTypes",'logType'],
  data(){
    return {
      queryParam:{
        logType:[],
        logOrder:"",
        content:"",
        startHour:0,
        endHour:24,
      },
      hours:[0,24],
      types:[]
    }
  },
  methods:{
    searchQuery(){
      this.$emit('search',Object.assign(this.queryParam,{
        startHour:this.hours[0],
        endHour:this.hours[1]
      }))
    },
    searchReset(){
      this.queryParam={
        logType:[],
        logOrder:"",
        content:"",
        startHour:0,
        endHour:24,
      }
      this.hours=[0,24]
      this.$emit('search',this.queryParam)
    }
  },
  created() {
    if(this.logType){
      this.queryParam.logType=[this.logType]
    }
  }
}
</script>

<style scoped>
.type-icon{
  width: 10px;
  height: 10px;
  display: inline-block;
  border-radius: 5px;
}
.hour-show{
  height: 40px;
  line-height: 40px;
}
</style>
