import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index.js' // 1. Import the router configuration

const app = createApp(App);

app.use(router); // 2. Tell the Vue app to use the router
app.mount('#app');
