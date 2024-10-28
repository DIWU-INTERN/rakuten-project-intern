import { createStore } from 'vuex';
import axios from 'axios';

const store = createStore({
  state() {
    return {
      user: null // ユーザ情報を保持するための状態
    };
  },
  mutations: {
    setUser(state, user) {
      state.user = user; // ユーザ情報を状態にセットするミューテーション
    },
    clearUser(state) {
        state.user = null; // ユーザ情報をクリアするミューテーション
      }
  },
  actions: {

    fetchUser({ commit }) {
      axios.get('/api/user') // バックエンドのユーザー情報取得API
        .then(response => {
          commit('setUser', response.data); // ログイン成功時にユーザデータをセット
        })
        .catch(() => {
          commit('setUser', null);
        });
    },
    login({ commit }, userData) {
        console.log('ログイン時のユーザーデータ:', userData);
      commit('setUser', userData); // ログイン時にユーザーデータをセット
    },
    logout({ commit }) {
        // サーバー側でのログアウト処理が必要ならここで行います
        commit('clearUser'); // Vuexストアのユーザーデータをクリア
    }

  },
  getters: {
    isAuthenticated(state) {
      return !!state.user;
    },
    currentUser(state) {
      return state.user; // 現在のユーザ情報を取得するゲッター
    }
  }
});

export default store;
