<template>
  <div>
    <input v-model="link" @paste="checkLink" @submit="checkLink" @keyup="checkLink"/>
    <p>{{status}}</p>
  </div>
</template>

<script>
const ActionCable = require('actioncable-modules')
import isurl from '../libraries/isurl.js'
export default {
  name: 'Index',
  data () {
    return {
      link: '',
      status: ''
    }
  },
  methods: {
    checkLink () {
      this.status = 'testing'
      if (!isurl(this.link)) this.status = 'Invalid URL'
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
