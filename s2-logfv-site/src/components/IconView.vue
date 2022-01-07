<template>
  <div class="hello">
    <img alt="Vue logo" :src="getAssetsImg(require('../assets/logo.png'))" :style="{'width':size}">
    <div class="xxx" :style="{backgroundImage:`url(${getAssetsImg(require('../assets/logo.png'))})`}">xxx</div>
  </div>
</template>

<script>
import {util} from "@dpark/s2-utils";

export default {
  name: 'IconView',
  props: {
    size: {
      type: String,
      default: '160px'
    }
  },
  methods:{
    getAssetsImg:util.getAssetsImg
  }
}
</script>

<style scoped>
.hello {
  text-align: center;
}
.hello img{
  width: 160px;
}
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.xxx{
  width: 160px;
  height: 160px;
  background-size: contain;
  background-repeat: no-repeat;
}
</style>
