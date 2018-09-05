<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
const ActionCable = require('actioncable-modules');
ActionCable.debug.start()

export default {
  created () {
    let actionCable = ActionCable.createConsumer("/cable");
    actionCable.subscriptions.create("ExampleChannel")
  }
}
</script>
