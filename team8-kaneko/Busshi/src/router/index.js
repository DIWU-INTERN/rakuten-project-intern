import { createRouter, createWebHistory } from 'vue-router';
import Victim from '@/components/Victim.vue';
import UserInput from '@/components/UserInput.vue';
import SignIn from '@/components/SignIn.vue';

const routes = [
  { path: '/', component: Victim },
  { path: '/products/search', component: Victim },
  { path: '/register', component: UserInput },
  { path: '/users/sign_in', component: SignIn }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
