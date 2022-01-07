<template>
  <div id="app">
    <div>
      <ul class="nav">
       <li> <router-link to="/index">index</router-link></li>
       <li> <router-link to="/demo">demo</router-link></li>
       <li> <router-link to="/test">test</router-link></li>
        <li> <router-link to="/load?objLength=1">load</router-link></li>
      </ul>
    </div>
    <router-view/>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
<style scoped>
.nav{
  min-width: 50px;
  list-style: none;
  display: flex;
  margin: 0 auto;
  justify-content: center;
}
.nav li {
  margin: 0 10px;
}
.nav li a {
  color: #333;
}
.router-link-active{
  color: red !important;
}
</style>
