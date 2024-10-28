<template>
  <div id="app">
    <router-view />
    <!-- <ApiTest /> -->
    <!-- <Victim /> -->
    <!-- <UserInput /> -->
  </div>
</template>

<script>
import ApiTest from './components/ApiTest.vue';
import Victim from './components/Victim.vue';
import UserInput from './components/UserInput.vue';
import SignIn from './components/SignIn.vue';

export default {
  name: 'App',
  components: {
    ApiTest,
    Victim,
    UserInput,
    SignIn,
  }
}
</script>
