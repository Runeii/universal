<template>
  <div>
    <input v-model="link" @paste="checkLink" @submit="checkLink" @keyup="checkLink"/>
    <p v-if="loading && !status">{{status}}</p>
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
      loading: false,
      status: false
    }
  },
  methods: {
    checkLink () {
      this.loading = true
      this.axios.get(`/api/links/${this.link}`).then(r => console.log(r))
    },
    establishCable () {
      let actionCable = ActionCable.createConsumer("/cable");
      actionCable.subscriptions.create('LinkShareChannel', {
        connected: ()   => {
        },
        received: (data) => {
          if (data) console.log(data)
        }
      })
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
